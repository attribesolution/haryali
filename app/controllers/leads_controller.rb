class LeadsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :update_status, :destroy]
  before_action :user_admin, only: [:index, :update_status, :destroy]
  before_action :load_lead, only: [:show, :destroy]

  def new
    @wizard = ModelWizard.new(Lead, session, params).start
    @lead = @wizard.object
    @plants = Plant.where(is_available: true).order(:id)
  end

  # def edit
  #   @wizard = ModelWizard.new(@lead, session, params).start
  # end

  def create
    @wizard = ModelWizard.new(Lead, session, params, lead_params).continue
    @lead = @wizard.object
    @locations = HaryaliLocation.select(:id, :address, :current, :target, :optional_address).where(is_active: :true).order(:created_at)
    if @wizard.save
      if User.where(email: @lead.email).count == 0
        user = User.new(email: @lead.email, password: 'password', password_confirmation: 'password', role: 0)
        user.skip_confirmation!
        user.save
        UserMailer.welcome_email(@lead).deliver
      else
        UserMailer.welcome_email_user(@lead).deliver
      end
      redirect_to @lead
    else
      render :new
    end
  end

  # def update
  #   @wizard = ModelWizard.new(@lead, session, params, lead_params).continue
  #   if @wizard.save
  #     redirect_to @lead, notice: 'Lead updated.'
  #   else
  #     render :edit
  #   end
  # end

  def index
    if Lead.count > 0
      @leads = true
    else
      @leads = false
    end
    @leads_placed = Lead.where(status: :Placed).order(created_at: :desc)
    @leads_confirmed = Lead.where(status: :Confirmed).order(created_at: :desc)
    @leads_paid = Lead.where(status: :Paid).order(created_at: :desc)
    @leads_planted = Lead.where(status: :Planted).order(created_at: :desc)
  end

  def update_status
    lead = Lead.find(params[:id])
    if lead.update_column(:status, params[:status])
      puts case params[:status]
      when 'Confirmed'
        UserMailer.notify_email_confirmed(lead).deliver
      when 'Paid'
        UserMailer.notify_email_paid(lead).deliver
      when 'Planted'
        UserMailer.notify_email_planted(lead).deliver
      end
    end
  end

  # DELETE /leads/1
  def destroy
    coupon = @lead.coupon
    if @lead.destroy
      coupon.is_active = true
      coupon.save
      redirect_to leads_url, notice: 'Lead was deleted successfully'
    end
  end

private

  def load_lead
    @lead = Lead.find_by(id: params[:id])
  end

  def lead_params
    return params unless params[:lead]

    params.require(:lead).permit(:current_step,
      :name,
      :contact,
      :email,
      :plant_id,
      :quantity,
      :payment_type,
      :location_type,
      :coupon_code,
      :location_id,
      :coupon_id,
      :dedicate_type,
      :dedicate_name,
      location_attributes: [:address,:lat,:lng,:type]
    )
  end
  
  def user_admin
    unless current_user && current_user.role == 'admin'
      redirect_to root_path
    end
  end
end

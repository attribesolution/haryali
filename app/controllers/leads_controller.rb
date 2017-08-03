class LeadsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :update_status, :destroy]
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
      UserMailer.welcome_email(@lead).deliver
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
    if Lead.all.size > 0
      @lead = true
    else
      @lead = false
    end
    @leads_placed = Lead.where(status: :Placed).order(created_at: :desc)
    @leads_confirmed = Lead.where(status: :Confirmed).order(created_at: :desc)
    @leads_paid = Lead.where(status: :Paid).order(created_at: :desc)
    @leads_planted = Lead.where(status: :Planted).order(created_at: :desc)
  end

  def update_status
    lead = Lead.find(params[:id])
    lead.update_column(:status, params[:status])
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
      location_attributes: [:address,:lat,:lng,:type]
    )
  end
end

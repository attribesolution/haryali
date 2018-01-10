class LeadsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :update_status, :destroy]
  before_action :user_admin, only: [:index, :update_status, :destroy]
  before_action :load_lead, only: [:show]

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
        user = User.new(email: @lead.email, password: 'password', password_confirmation: 'password', role: 0, name: @lead.name)
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

  def update_detail
    lead = Lead.find(params[:lead_id])
    lead.update(status: "Confirmed", address: params[:address], payment_date: params[:payment_date], comment: params[:comment])
    if lead.save
      UserMailer.notify_email_confirmed(lead).deliver
      redirect_to leads_url, notice: 'Lead was updated successfully'
    end
  end

  # def timeline_event
  #   lead = Lead.find(params[:lead_id])
  #   lead.update(status: "Planted", planted_date: params[:planted_date], comment: params[:comment])
  #   timeline_event = TimelineEvent.new(image: params[:image], location_id: lead.location_id, lead_id: lead.id)
  #   timeline_event.save!
  #   if lead.save
  #     UserMailer.notify_email_planted(lead).deliver
  #     redirect_to leads_url, notice: 'Lead was updated successfully'
  #   end
  # end

  def index
    if Lead.count > 0
      @leads = true
    else
      @leads = false
    end
    @leads_placed = Lead.where(status: :Placed, archive: false).order(payment_date: :asc)
    @leads_confirmed = Lead.where(status: :Confirmed, archive: false).order(payment_date: :asc)
    @leads_paid = Lead.where(status: :Paid, archive: false).order(payment_date: :asc)
    @leads_planted = Lead.where(status: :Planted, archive: false).order(payment_date: :asc)
  end

  def update_status
    lead = Lead.find(params[:id])
    if lead.update_column(:status, params[:status])
      puts case params[:status]
      # when 'Confirmed'
      #   UserMailer.notify_email_confirmed(lead).deliver
      when 'Paid'
        UserMailer.notify_email_paid(lead).deliver
        UserMailer.payment_email_accountant(lead).deliver
      # when 'Planted'
      #   UserMailer.notify_email_planted(lead).deliver
      end
    end
  end

  # DELETE /leads/1
  def destroy
    coupon = @lead.coupon
    user = @lead.email
    if @lead.destroy
      coupon.is_active = true
      coupon.save
      redirect_to leads_url, notice: 'Lead was deleted successfully'
    end
  end

  def archive
    lead = Lead.find_by(id: params[:lead_id])
    lead.archive = true
    lead.save
    redirect_to leads_url, notice: 'Lead was archived successfully'
  end

  def payment_date_update
    lead = Lead.find_by(id: params[:lead_id])
    lead.update_column(:payment_date, params[:new_payment_date])
    redirect_to leads_url
  end

private

  def load_lead
    @lead = Lead.find_by(id: params[:id])
    @updates = @lead.updates.order(created_at: :DESC)
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

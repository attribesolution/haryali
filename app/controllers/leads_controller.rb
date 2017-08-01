class LeadsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :update_status]
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
    @leads = Lead.all.order(created_at: :desc)
    @leads_placed = Lead.where(status: :placed).order(created_at: :desc)
    @leads_confirmed = Lead.where(status: :confirmed).order(created_at: :desc)
    @leads_paid = Lead.where(status: :paid).order(created_at: :desc)
    @leads_planted = Lead.where(status: :planted).order(created_at: :desc)
  end

  def update_status
    lead = Lead.find(params[:id])
    lead.update_column(:status, params[:status])
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

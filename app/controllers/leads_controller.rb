class LeadsController < ApplicationController
  before_action :load_lead

  def new
    @wizard = ModelWizard.new(Lead, session, params).start
    @lead = @wizard.object
    @plants = Plant.where(is_available: true)
  end

  # def edit
  #   @wizard = ModelWizard.new(@lead, session, params).start
  # end

  def create
    @wizard = ModelWizard.new(Lead, session, params, lead_params).continue
    @lead = @wizard.object
    @locations = HaryaliLocation.select(:id, :address, :current, :target).where(is_active: :true).order(:created_at)
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

class LeadsController < ApplicationController
  before_action :load_lead

  def new
    @wizard = ModelWizard.new(Lead, session, params).start
    @lead = @wizard.object
  end

  # def edit
  #   @wizard = ModelWizard.new(@lead, session, params).start
  # end

  def create
    @wizard = ModelWizard.new(Lead, session, params, lead_params).continue
    @lead = @wizard.object
    if @wizard.save
      redirect_to @lead, notice: "Thank you!"
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
      :address,
      :quantity,
      :payment_type
    )
  end
end

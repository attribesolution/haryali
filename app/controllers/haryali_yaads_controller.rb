class HaryaliYaadsController < ApplicationController
  def index
    @lead = Lead.new
  end

  def submit_form
    lead = Lead.new
    lead.name = params[:name]
    lead.contact = params[:phone]
    lead.email = params[:email]
    lead.dedicate_name = params[:memory]
    lead.dedicate_type = 'memory'
    if lead.save
      if User.where(email: params[:email]).count == 0
        user = User.new(email: params[:email], password: 'password', password_confirmation: 'password', role: 0)
        user.skip_confirmation!
        user.save
        UserMailer.welcome_email(lead).deliver
      else
        UserMailer.welcome_email_user(lead).deliver
      end
    else 
      return false
    end
  end
end

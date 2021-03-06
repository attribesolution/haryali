class UserMailer < ApplicationMailer
  default from: "attribesolution@gmail.com"

  def admin_email(lead)
    @lead = lead
    @url  = "http://"+Rails.application.secrets.domain_name
    mail(to: Rails.application.secrets.admin_email, 
      subject: "Haryali.pk - Plant Owning Email",
      bcc: ["kashif.y.saeed@gmail.com"])
  end

  def welcome_email(lead)
    @lead = lead
    @url  = "http://"+Rails.application.secrets.domain_name
    mail(to: @lead.email, 
    	subject: "Haryali.pk - Plant Owning Request",
    	bcc: ["kashif.y.saeed@gmail.com"])
  end

  def login_information(lead)
    @lead = lead
    @url  = "http://"+Rails.application.secrets.domain_name
    mail(to: @lead.email, 
      subject: "Haryali.pk - Login Information",
      bcc: ["kashif.y.saeed@gmail.com"])
  end

  def welcome_email_user(lead)
    @lead = lead
    @url  = "http://"+Rails.application.secrets.domain_name
    mail(to: @lead.email, 
      subject: "Haryali.pk - Plant Donation Request",
      bcc: ["kashif.y.saeed@gmail.com"])
  end

  def notify_email_confirmed(lead)
    @lead = lead
    @url  = "http://"+Rails.application.secrets.domain_name
    mail(to: lead.email, 
    	subject: "Haryali.pk - Plant Donation Request Confirmed")
  end

  def notify_email_paid(lead)
    @lead = lead
    @url  = "http://"+Rails.application.secrets.domain_name
    mail(to: lead.email, 
      subject: "Haryali.pk - Payment for Plant Donation Received")
  end

  def notify_email_planted(lead)
    @lead = lead
    @url  = "http://"+Rails.application.secrets.domain_name+'/visitors/'+@lead.id.to_s
    mail(to: lead.email, 
      subject: "Haryali.pk - Your #{@lead.quantity > 1 ? 'Plants have' : 'Plant has'} been Planted")
  end

  def update_email(lead)
    @lead = lead
    @url  = "http://"+Rails.application.secrets.domain_name
    mail(to: lead.email, 
      subject: "Haryali.pk - Update regarding your #{@lead.quantity > 1 ? 'Plants' : 'Plant'}")
  end

  def payment_email_customer(lead)
    @lead = lead
    @url  = "http://"+Rails.application.secrets.domain_name
    mail(to: lead.email, 
      subject: "Haryali.pk - Update regarding your payment")
  end 

  def payment_email_accountant(lead)
    @lead = lead
    @url  = "http://"+Rails.application.secrets.domain_name
    mail(to: Rails.application.secrets.accountant_email, 
      subject: "Haryali.pk - Update regarding customer's payment")
  end
end

class UserMailer < ApplicationMailer
  default from: "attribesolution@gmail.com"

  def welcome_email(lead)
    @lead = lead
    @url  = "http://haryali.pk"
    mail(to: @lead.email, 
    	subject: "Haryali.pk - Plant Owning Request",
    	bcc: ["kashif.y.saeed@gmail.com"])
  end

  def welcome_email_user(lead)
    @lead = lead
    @url  = "http://haryali.pk"
    mail(to: @lead.email, 
      subject: "Haryali.pk - Plant Donation Request",
      bcc: ["kashif.y.saeed@gmail.com"])
  end

  def notify_email_confirmed(lead)
    @lead = lead
    @url  = "http://plant.haryali.pk"
    mail(to: lead.email, 
    	subject: "Haryali.pk - Plant Donation Request Confirmed")
  end

  def notify_email_paid(lead)
    @lead = lead
    @url  = "http://plant.haryali.pk"
    mail(to: lead.email, 
      subject: "Haryali.pk - Payment for Plant Donation Received")
  end

  def notify_email_planted(lead)
    @lead = lead
    @url  = "http://plant.haryali.pk"
    mail(to: lead.email, 
      subject: "Haryali.pk - Your #{@lead.quantity > 1 ? 'Plants have' : 'Plant has'} been Planted")
  end

  def update_email(lead)
    @lead = lead
    @url  = "http://plant.haryali.pk"
    mail(to: lead.email, 
      subject: "Haryali.pk - Update regarding your #{@lead.quantity > 1 ? 'Plants' : 'Plant'}")
  end
end

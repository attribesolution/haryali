class UserMailer < ApplicationMailer
  default :from => "attribesolution@gmail.com"


  def welcome_email(lead)
    @lead = lead
    @url  = "http://haryali.pk"
    mail(:to => @lead.email, :subject => "Haryali.pk - Plant Owning Request")
  end
end

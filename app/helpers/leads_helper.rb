module LeadsHelper

  def total_price lead
    html = ""
    if lead.coupon.nil?
      html = <<-HTML
        <span> Rs. #{lead.total_price(lead.quantity)}</span>
      HTML
    else
      html = <<-HTML
        <strike> Rs. #{lead.quantity * lead.plant.price}</strike>
        <span> Rs. #{lead.total_price(lead.quantity)}</span>
      HTML
    end
    html.html_safe
  end

  def percentage loc
    per = 100*loc.current.to_f/loc.target.to_f
  end
end

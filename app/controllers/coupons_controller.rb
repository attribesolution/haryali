class CouponsController < ApplicationController

  def show
    code = params[:id]    
    coupon = Coupon.find_by_code(code)

    if coupon.nil?
      response = { error: true, coupon: coupon }
    else
      response = { error: false, coupon: coupon }
    end

    respond_to do |format|
      format.json { render json: response }
      format.html
    end

  end
end

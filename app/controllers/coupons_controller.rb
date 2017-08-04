class CouponsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def show
    code = params[:id]    
    coupon = Coupon.active.find_by_code(code)

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

  def index
    if Coupon.all.size > 0
      @coupon = true
    else
      @coupon = false
    end
    @coupons_available = Coupon.where(is_active: :true).order(created_at: :desc)
    @coupons_used = Coupon.where(is_active: :false).order(created_at: :desc)
  end
end

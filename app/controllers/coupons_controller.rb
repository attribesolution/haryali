class CouponsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :generate_coupons]
  before_action :user_admin, only: [:index, :generate_coupons]

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
      @coupons = true
    else
      @coupons = false
    end
    @coupons_available = Coupon.where(is_active: :true).order(created_at: :desc)
    @coupons_used = Coupon.where(is_active: :false).order(created_at: :desc)
  end

  def generate_coupons
    count = params[:quantity].to_i
    loop do 
      tries = 5
      coupon = Coupon.new
      loop do
        coupon.generate_code
        result = Coupon.find_by_code(coupon.code)
        tries = tries - 1
        break if result.nil? || tries == 0
      end
      if tries > 0
        coupon.save
      end
      count = count - 1
      break if count == 0
    end
  end

  private
    def user_admin
      unless current_user && current_user.role == 'admin'
        redirect_to root_path
      end
    end
end

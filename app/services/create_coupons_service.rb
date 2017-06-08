class CreateCouponsService
  def initialize size
    @size = size
  end
  def call
    @size.times do
      begin
        coupon = Coupon.new
      end while !coupon.save
    end
    puts "Coupons created: #{Coupon.active.count}"
  end
end

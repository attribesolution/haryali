class Lead < ApplicationRecord
  belongs_to :plant
  belongs_to :location, optional: true
  belongs_to :coupon, optional: true
  accepts_nested_attributes_for :location, reject_if: :check_location_type, allow_destroy: true

  enum payment_type: [:cash_on_delivery, :direct_wire_transfer]

  validates :name, :contact, :plant, presence: true, if: :step1?
  validates :quantity, :payment_type,:location, presence: true, if: :step2?
  validates :quantity, numericality: true, if: :step2?

  after_create :deactivate_coupon
  
  attr_accessor :coupon_code
  attr_accessor :location_type

  include MultiStepModel

  def self.total_steps
    2
  end

  def total_price quantity = 1
    return 0 if self.plant.nil?
    return self.plant.price * quantity - self.discount
  end

  def discount
    return (self.plant.nil? or self.coupon.nil?) ? 0 : self.plant.price
  end

  private
    def check_location_type
      return true if self.step1?
      if self.location_type == "HaryaliLocation"
        return true
      end
      return false
    end

    def deactivate_coupon
      return true if self.coupon.nil?
      self.coupon.de_activate
    end
end

class Lead < ApplicationRecord
  belongs_to :plant
  belongs_to :location, optional: true
  belongs_to :coupon, optional: true
  accepts_nested_attributes_for :location, reject_if: :check_location_type, allow_destroy: true

  enum payment_type: [:cash_on_delivery, :direct_wire_transfer]

  validates :name, :contact, :plant, presence: true, if: :step1?
  validates :quantity, :payment_type,:location, presence: true, if: :step2?
  validates :quantity, numericality: true, if: :step2?

  before_create :verify_coupon
  after_create :deactivate_coupon, :update_location_progress
  
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

    def verify_coupon
      coupon = Coupon.find_by_id(self.coupon_id)
      if coupon.nil? 
        return 
      end
      unless coupon[:is_active]
        self.coupon = nil
      end
    end

    def update_location_progress
      location = Location.find_by_id(self.location_id)
      location[:current] += 1
      if location[:current] == location[:target]
        location[:is_active] = false
      end
      location.save
    end
end

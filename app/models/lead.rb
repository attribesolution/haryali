class Lead < ApplicationRecord
  belongs_to :plant
  belongs_to :location, optional: true
  accepts_nested_attributes_for :location, reject_if: :check_location_type, allow_destroy: true

  enum payment_type: [:cash_on_delivery, :direct_wire_transfer]

  validates :name, :contact, :plant, presence: true, if: :step1?
  validates :quantity, :payment_type,:location, presence: true, if: :step2?
  validates :quantity, numericality: true, if: :step2?
  
  attr_accessor :coupon_code
  attr_accessor :location_type

  include MultiStepModel

  def self.total_steps
    2
  end

  private
    def check_location_type
      return true if self.step1?
      if self.location_type == "HaryaliLocation"
        return true
      end
      return false
    end
end

class Lead < ApplicationRecord
  belongs_to :plant

  enum payment_type: [:cash_on_delivery, :direct_wire_transfer]

  validates :name, :contact, :plant, presence: true, if: :step1?
  validates :address, :quantity, :payment_type, presence: true, if: :step2?
  validates :quantity, numericality: true, if: :step2?

  include MultiStepModel

  def self.total_steps
    2
  end
end

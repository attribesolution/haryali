class Coupon < ApplicationRecord

  has_one :lead
  validates_uniqueness_of :code
  before_create :generate_code

  scope :active,->{where(is_active: true)}


  def de_activate
    self.update(is_active: false)
  end

  def generate_code
    key = Digest::MD5.hexdigest(Time.now.to_s + rand(100000).to_s)[0..5]
    self.code = "Haryali-#{key}"
  end
end

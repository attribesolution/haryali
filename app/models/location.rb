class Location < ApplicationRecord
  has_many :leads
  validates :address, :lat,:lng, presence: true
end

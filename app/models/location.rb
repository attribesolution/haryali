class Location < ApplicationRecord
  has_many :leads, dependent: :destroy 
  has_many :timeline_events, dependent: :destroy 
  
  accepts_nested_attributes_for :timeline_events, reject_if: :all_blank, allow_destroy: true

  validates :address, :lat,:lng, presence: true
end

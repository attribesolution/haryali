class Plant < ApplicationRecord
  has_many :leads, dependent: :destroy
end

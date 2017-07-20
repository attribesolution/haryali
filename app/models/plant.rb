class Plant < ApplicationRecord
  has_many :leads, dependent: :destroy

  mount_uploader :image, ImageUploader
end

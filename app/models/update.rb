class Update < ApplicationRecord
  belongs_to :lead

  mount_uploader :image, ImageUploader
end

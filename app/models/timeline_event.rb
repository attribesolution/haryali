class TimelineEvent < ApplicationRecord
	belongs_to :location
  belongs_to :lead

	mount_uploader :image, ImageUploader
end

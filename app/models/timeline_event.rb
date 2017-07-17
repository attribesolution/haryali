class TimelineEvent < ApplicationRecord
	belongs_to :location

	mount_uploader :image, ImageUploader
end

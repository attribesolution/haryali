class Product < ApplicationRecord
  belongs_to :sub_category

  validates_presence_of :name, :price

  mount_uploader :image, ImageUploader

  attr_accessor :category_id
  
end

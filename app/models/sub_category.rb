class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :products

  validates_presence_of :name
end

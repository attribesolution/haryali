class Category < ApplicationRecord

  has_many :sub_categories, dependent: :destroy

  scope :parent_only, -> { where(parent_id: 0) }
  
  validates_presence_of :name
  
  before_validation :set_parent_id, on: [:create, :update]

  def set_parent_id
    if self.parent_id==nil
      self.parent_id=0
    end
  end
  
  def children
    Category.where(parent_id: self.id)
  end
end

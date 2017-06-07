class Plant < ApplicationRecord
  has_many :leads

  def name_with_price_label
    name + "- RS. " + price.to_s
  end
end

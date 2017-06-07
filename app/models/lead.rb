class Lead < ApplicationRecord
  belongs_to :plant
  belongs_to :coupon
end

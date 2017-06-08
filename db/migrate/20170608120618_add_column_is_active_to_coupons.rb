class AddColumnIsActiveToCoupons < ActiveRecord::Migration[5.1]
  def change
    add_column :coupons, :is_active, :boolean,default: true
  end
end

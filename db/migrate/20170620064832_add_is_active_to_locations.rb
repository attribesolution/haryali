class AddIsActiveToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :is_active, :boolean, default: true
  end
end

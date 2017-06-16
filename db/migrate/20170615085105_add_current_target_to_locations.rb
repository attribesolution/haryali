class AddCurrentTargetToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :current, :integer, default: 0, null: false
    add_column :locations, :target, :integer, default: 0, null: false
  end
end

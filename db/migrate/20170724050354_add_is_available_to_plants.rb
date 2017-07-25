class AddIsAvailableToPlants < ActiveRecord::Migration[5.1]
  def change
    add_column :plants, :is_available, :boolean, default: true, null: false
  end
end

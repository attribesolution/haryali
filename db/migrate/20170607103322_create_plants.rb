class CreatePlants < ActiveRecord::Migration[5.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.float :price
      t.string :detail

      t.timestamps
    end
  end
end

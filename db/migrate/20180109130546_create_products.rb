class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.references :sub_category, foreign_key: true
      t.string :name
      t.string :image
      t.string :price
      t.string :rating
      t.string :description
      t.string :comment

      t.timestamps
    end
  end
end

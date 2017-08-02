class CreateUpdates < ActiveRecord::Migration[5.1]
  def change
    create_table :updates do |t|
      t.references :lead, foreign_key: true
      t.string :title
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end

class CreateLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :contact
      t.string :email
      t.references :plant, foreign_key: true
      t.string :address
      t.integer :quantity
      t.integer :payment_type

      t.timestamps
    end
  end
end

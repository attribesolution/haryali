class AddColumnsToLeads < ActiveRecord::Migration[5.1]
  def change
    add_column :leads, :payment_date, :datetime
    add_column :leads, :comment, :string
  end
end

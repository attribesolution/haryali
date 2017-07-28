class AddStatusToLeads < ActiveRecord::Migration[5.1]
  def change
    add_column :leads, :status, :string, default: 'placed', null: false
  end
end

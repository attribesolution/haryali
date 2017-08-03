class AddDedicateTypeDedicateNameToLeads < ActiveRecord::Migration[5.1]
  def change
    add_column :leads, :dedicate_type, :string
    add_column :leads, :dedicate_name, :string
  end
end

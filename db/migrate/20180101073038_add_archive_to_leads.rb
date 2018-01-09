class AddArchiveToLeads < ActiveRecord::Migration[5.1]
  def change
    add_column :leads, :archive, :boolean, default: false
  end
end

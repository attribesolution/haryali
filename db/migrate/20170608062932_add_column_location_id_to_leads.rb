class AddColumnLocationIdToLeads < ActiveRecord::Migration[5.1]
  def change
    add_column :leads, :location_id, :integer
  end
end

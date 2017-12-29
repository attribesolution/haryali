class AddPlantedDateToLeads < ActiveRecord::Migration[5.1]
  def change
    add_column :leads, :planted_date, :datetime
  end
end

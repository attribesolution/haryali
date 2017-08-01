class ChangeStatusDefaultToCapital < ActiveRecord::Migration[5.1]
  def change
		change_column :leads, :status, :string, default: 'Placed', null: false
  end
end

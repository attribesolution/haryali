class AddOptionalAddressToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :optional_address, :string
  end
end

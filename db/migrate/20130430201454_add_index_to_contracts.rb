class AddIndexToContracts < ActiveRecord::Migration
  def change
    add_index :contracts, :close_contract
    add_index :contracts, :active
#    add_index :contracts, :t_car cant because :t_cat string
  end
end

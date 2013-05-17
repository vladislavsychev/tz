class ChangeColumnForContracts < ActiveRecord::Migration
  def up
     change_column :contracts, :contractor_mphone, :string, limit: 18
  end

  def down
  end
end

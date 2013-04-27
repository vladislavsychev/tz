class ChangeContracts < ActiveRecord::Migration
  def change
    change_table :contracts do |t|
      t.remove :t_car
      t.string :t_car, limit: 30
      t.index :t_car
    end
  end
end

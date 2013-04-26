class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :t_car, limit: 2
      t.string :city_rent, limit: 99
      t.date :date_rent
      t.string :time_rent, limit: 5
      t.integer :lease_time, limit: 2
      t.text :body_contract, limit: 2048
      t.string :contractor_mphone, limit: 12
      t.string :contractor_email, limit: 140
      t.string :contractor_name, limit: 50
      t.boolean :active, default: false
      t.boolean :close_contract, default: false

      t.timestamps
    end
      add_index :contracts, [:date_rent, :active]
     
  end
end

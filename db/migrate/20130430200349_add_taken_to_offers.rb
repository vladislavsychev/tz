class AddTakenToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :taken, :boolean, default: false
  
    add_index :offers, :taken
    add_index :offers, :user_id
    add_index :offers, :contract_id
  end
end

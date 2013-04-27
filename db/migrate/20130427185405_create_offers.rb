class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :contract_id
      t.integer :user_id
      t.integer :price
      t.string :adword

      t.timestamps
    end
  end
end

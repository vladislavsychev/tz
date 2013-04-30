class RemoveTakenFromOffers < ActiveRecord::Migration
  def up
    remove_column :offers, :taken
  end

  def down
      add_column :offers, :taken, :boolean, default: false
  end
end

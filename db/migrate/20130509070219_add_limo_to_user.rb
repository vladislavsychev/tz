class AddLimoToUser < ActiveRecord::Migration
  def change
    add_column :users, :limo, :boolean, :default => false
    add_column :users, :van, :boolean, :default => false
  end
end

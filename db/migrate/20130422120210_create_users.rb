class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :mphone
      t.integer :raiting
      t.boolean :admin
      t.boolean :moderator

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :mphone, unique: true
  end
end

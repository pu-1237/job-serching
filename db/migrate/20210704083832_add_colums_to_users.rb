class AddColumsToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name_kana, :string
    add_column :users, :first_name_kana, :string
    add_column :users, :address, :string
    add_column :users, :postal_code, :string
    add_column :users, :station, :string
  end
  def down
    remove_column :users, :last_name
    remove_column :users, :first_name
    remove_column :users, :last_name_kana
    remove_column :users, :first_name_kana
    remove_column :users, :address
    remove_column :users, :postal_code
    remove_column :users, :station
  end
end

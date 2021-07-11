class AddColumsToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name_kana, :string
    add_column :users, :first_name_kana, :string
    add_column :users, :postcode, :integer
    add_column :users, :prefecture_code, :integer
    add_column :users, :address_city, :string
    add_column :users, :address_street, :string
    add_column :users, :station, :string
    add_column :users, :gender, :string
    add_column :users, :birthday, :date
  end
  def down
    remove_column :users, :last_name
    remove_column :users, :first_name
    remove_column :users, :last_name_kana
    remove_column :users, :first_name_kana
    remove_column :users, :postcode, :integer
    remove_column :users, :prefecture_code
    remove_column :users, :address_city
    remove_column :users, :address_street
    remove_column :users, :station
    remove_column :users, :gender
    remove_column :users, :birthday
  end
end

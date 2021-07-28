class ChangeColumnsAddNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :number, :string, null: false
    change_column :users, :last_name, :string, null: false
    change_column :users, :first_name, :string, null: false
    change_column :users, :last_name_kana, :string, null: false
    change_column :users, :first_name_kana, :string, null: false
    change_column :users, :postcode, :integer, null: false
    change_column :users, :prefecture_code, :integer, null: false
    change_column :users, :address_city, :string, null: false
    change_column :users, :address_street, :string, null: false
    change_column :users, :station, :string, null: false
    change_column :users, :birthday, :date, null: false
    change_column :users, :gender, :string, null: false
    change_column :events, :limit, :integer, null: false
    change_column :events, :deadline, :datetime, null: false
  end
end

class AddNumberToUser < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :number, :string
  end
  def down
    remove_column :users, :number
  end
end
class RemoveNameToUsers < ActiveRecord::Migration[6.1]
  def up
    remove_column :users, :name
  end
  def down
    add_column :users, :name, :string
  end
end

class AddLimitToEvent < ActiveRecord::Migration[6.1]
  def up
    add_column :events, :limit, :integer
  end
  def down
    remove_column :events, :limit
  end
end

class AddDeadLineToEvents < ActiveRecord::Migration[6.1]
  def up
    add_column :events, :deadline, :datetime
  end
  def down
    remove_column :events, :deadline
  end
end

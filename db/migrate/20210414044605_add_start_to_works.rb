class AddStartToWorks < ActiveRecord::Migration[6.1]
  def up
    add_column :works, :start, :datetime
    add_column :works, :end, :datetime
    remove_column :works, :work_at
  end
  def down
    add_column :works, :work_at
  end
end

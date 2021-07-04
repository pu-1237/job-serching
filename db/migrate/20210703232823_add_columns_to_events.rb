class AddColumnsToEvents < ActiveRecord::Migration[6.1]
  def up
    add_column :events, :place, :string
    add_column :events, :allowance, :integer
    add_column :events, :remark, :string
  end
  def down
    remove_column :events, :place
    remove_column :events, :allowance
    remove_column :events, :remark
  end
end
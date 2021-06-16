class AddImageUrlToEvents < ActiveRecord::Migration[6.1]
  def up
    add_column :events, :imageurl, :string, default: 'work_icon2.png'
  end
  def down
    remove_column :events, :imageurl
  end
end

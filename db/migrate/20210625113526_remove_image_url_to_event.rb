class RemoveImageUrlToEvent < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :imageurl
  end
end

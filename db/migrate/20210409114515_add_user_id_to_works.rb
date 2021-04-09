class AddUserIdToWorks < ActiveRecord::Migration[6.1]
  def change
      add_reference :works, :user, foreign_key: true
  end
end

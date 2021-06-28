class AddResetDigestToUser < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_at, :datetime
  end
  def down
    remove_column :users, :reset_digest
    remove_column :users, :reset_sent_at
  end
end

class RenameColumns < ActiveRecord::Migration[6.1]
  def change
    rename_column :event_applicants, :work_id, :event_id
  end
end

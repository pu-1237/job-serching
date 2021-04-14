class RenameTables < ActiveRecord::Migration[6.1]
  def change
    rename_table :works, :events
    rename_table :work_applicants, :event_applicants
  end
end

class AddAttendanceToEventApplicants < ActiveRecord::Migration[6.1]
  def up
    add_column :event_applicants, :attendance, :boolean, default: false, null: false
  end
  def down
    remove_column :event_applicants, :attendance
  end
end

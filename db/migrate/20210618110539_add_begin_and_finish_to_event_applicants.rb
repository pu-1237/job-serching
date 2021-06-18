class AddBeginAndFinishToEventApplicants < ActiveRecord::Migration[6.1]
  def up
    add_column :event_applicants, :begin, :datetime
    add_column :event_applicants, :finish, :datetime
  end
  def down
    remove_column :event_applicants, :begin
    remove_column :event_applicants, :finish
  end
end

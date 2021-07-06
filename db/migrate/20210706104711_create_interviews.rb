class CreateInterviews < ActiveRecord::Migration[6.1]
  def change
    create_table :interviews do |t|
      t.datetime :start
      t.integer :limit

      t.timestamps
    end
  end
end

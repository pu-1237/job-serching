class CreateInterviewRegistrants < ActiveRecord::Migration[6.1]
  def change
    create_table :interview_registrants do |t|
      t.references :interview, foreign_key: true
      t.references :registrant, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end

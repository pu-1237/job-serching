class CreateWorkApplicants < ActiveRecord::Migration[6.1]
  def change
    create_table :work_applicants do |t|
      t.references :work, foreign_key: true
      t.references :applicant, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end

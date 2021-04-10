class WorkApplicant < ApplicationRecord
    belongs_to :applicant, class_name: 'User', foreign_key: 'applicant_id'
    validates_uniqueness_of :work_id, scope: :applicant_id
end

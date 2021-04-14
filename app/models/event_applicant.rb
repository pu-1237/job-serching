class EventApplicant < ApplicationRecord
    belongs_to :applicant, class_name: 'User', foreign_key: 'applicant_id'
    validates_uniqueness_of :event_id, scope: :applicant_id
end

class InterviewRegistrant < ApplicationRecord
    belongs_to :registrant, class_name: 'User', foreign_key: 'registrant_id'
    validates_uniqueness_of :interview_id, scope: :registrant_id
end
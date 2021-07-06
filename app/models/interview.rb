class Interview < ApplicationRecord
    belongs_to :user

    has_many :interview_registrants, dependent: :destroy
    has_many :registrants, through: :interview_registrants, dependent: :destroy
end

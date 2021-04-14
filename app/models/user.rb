class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, email: {allow_blank: true}

    has_many :events, dependent: :destroy
    has_many :event_applicants, foreign_key: 'applicant_id'
end

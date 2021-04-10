class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, email: {allow_blank: true}

    has_many :works, dependent: :destroy
    has_many :work_applicants, foreign_key: 'applicant_id'
end

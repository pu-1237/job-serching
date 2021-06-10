class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, email: {allow_blank: true}

    has_many :events, dependent: :destroy
    has_many :event_applicants, foreign_key: 'applicant_id'

    has_one_attached :profile_picture
    attribute :new_profile_picture

    before_save do
        if new_profile_picture
            self.profile_picture = new_profile_picture
        end 
    end
end

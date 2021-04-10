class Work < ApplicationRecord
    validates :title, :description, :wages, :work_at, presence: true

    belongs_to :user

    has_many :work_applicants, dependent: :destroy
    has_many :applicants, through: :work_applicants, dependent: :destroy
end

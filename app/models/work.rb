class Work < ApplicationRecord
    validates :title, :description, :wages, :work_at, presence: true

    belongs_to :user
end

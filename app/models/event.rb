class Event < ApplicationRecord
    validates :title, :description, :place, :wages, :allowance, :limit, presence: true

    validate  :start_end_check

    belongs_to :user

    has_many :event_applicants, dependent: :destroy
    has_many :applicants, through: :event_applicants, dependent: :destroy

    accepts_nested_attributes_for :event_applicants

    default_scope -> { order(start: :asc) }

    #時間の矛盾を防ぐ
    def start_end_check
        if self.start.present? && self.end.present?
            errors.add(:end, "が開始時刻を上回っています。正しく記入してください。") if self.start > self.end 
        end
    end


    def self.ransackable_attributes(auth_object = nil)
        %w[title id]
    end
    
    def self.ransakable_associations(auth_object = nil)
        []
    end
end

class News < ApplicationRecord
    validates :title, :text, presence: true
end

class Task < ApplicationRecord
    belongs_to :user
    def completed?
        !completed_at.blank?
    end
    validates :title,presence: true,length: {minimum: 5,maximum: 50}
    validates :desc,presence: true, length: { minimum: 100 }
end

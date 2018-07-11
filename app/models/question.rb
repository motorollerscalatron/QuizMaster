class Question < ApplicationRecord
  belongs_to :user
  has_many :challenges, class_name: "Challenge", foreign_key: "question_id"
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 255}, allow_blank: false
  validates :answer, length: { maximum: 255 }
end

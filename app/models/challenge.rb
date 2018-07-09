class Challenge < ApplicationRecord
  attr_accessor :my_answer

  belongs_to :user,     class_name: "User"
  belongs_to :question, class_name: "Question"
  validates :user_id,     presence: true
  validates :question_id, presence: true
  validates :my_answer,   presence: true
end

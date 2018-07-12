class Question < ApplicationRecord
  belongs_to :user
  has_many :challenges, class_name: "Challenge", foreign_key: "question_id"
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 255}, allow_blank: false
  validates :answer, length: { maximum: 255 }

  def self.get_solved(user_id)

    @question_public_filtered = Array.new

    @question_public = Question.where("is_public = ?", 't')
    @my_challenge_question = Challenge.select("question_id").where("user_id = ? and result = ?", user_id, 't')
    @my_challenge_question_ids = @my_challenge_question.distinct.pluck("question_id")

    for q in @question_public do
      @question_public_filtered.push(q) unless @my_challenge_question_ids.include?(q.id)
    end

    return @question_public_filtered
  end
end

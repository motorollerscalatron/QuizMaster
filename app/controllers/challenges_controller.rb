class ChallengesController < ApplicationController
  before_action :logged_in_user

  # provides a challenge form for a certain question
  def new
    @challenge = Challenge.new
    @question = Question.find(params[:question_id])
    redirect_to questions_path if @question.user_id != current_user.id and @question.is_public == false
    @challenge.question = @question
  end

  # makes a new challenge
  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.user = current_user

    @question = Question.find(@challenge.question_id)

    @challenge.result = (@challenge.matchAnswer(@challenge.my_answer)) ? 't' : 'f'

    #TODO: More subtle feedback rather than binary, based on the distance between the correct answer and the user's submission
    @assessment = (@challenge.matchAnswer(@challenge.my_answer)) ? Challenge::FEEDBACK_CORRECT : Challenge::FEEDBACK_INCORRECT 

    if @challenge.question.user == current_user
      render template: "/challenges/result"
    else
      if @challenge.save
        render template: "/challenges/result"
      else
        render new_challenge_path(question_id: params[:question_id])
      end
    end
  end

  private

    def challenge_params
      params.require(:challenge).permit(:question_id, :my_answer)
    end
end

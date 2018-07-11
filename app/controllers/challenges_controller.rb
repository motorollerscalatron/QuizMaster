class ChallengesController < ApplicationController
  before_action :logged_in_user

  def new
    @challenge = Challenge.new
    @question = Question.find(params[:question_id])
    @challenge.question = @question
  end

  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.user = current_user

    @question = Question.find(@challenge.question_id)

#    @challenge.result = (@question.answer == @challenge.my_answer) ? 't' : 'f' 
#    @assessment =  (@question.answer == @challenge.my_answer) ? "Your answer is correct." : "Oops, you can try again."

#    @challenge.result = @challenge.matchAnswer(@challenge.my_answer) ? 't' : 'f' 
#    @assessment = @challenge.matchAnswer(@challenge.my_answer) ? "Your answer is correct." : "Oops, you can try again."

    @challenge.result = true
    @assessment = @challenge.matchAnswer(@challenge.my_answer)

    if @challenge.save
      render template: "/challenges/result"
    else
      render new_challege_path(question_id: params[:question_id])
    end
  end

  private

    def challenge_params
      params.require(:challenge).permit(:question_id, :my_answer)
    end
end

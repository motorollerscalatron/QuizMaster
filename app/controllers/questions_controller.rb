class QuestionsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @question = Question.where("is_public = ?", 't').paginate(page: params[:page])
#    @question = Question.paginate(page: params[:page])

    render 'questions/index'
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "Questions created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
    else
      render 'edit'
    end
  end  

  def destroy
    @question.destroy
    flash[:success] = "Question deleted"
    redirect_to request.referrer || root_url
  end

  private

    def question_params
      params.require(:question).permit(:description, :answer, :is_public)
    end

    def correct_user
      @question = current_user.questions.find_by(id: params[:id])
      redirect_to root_url if @question.nil?
    end
end

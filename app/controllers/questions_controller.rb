require 'will_paginate/array'

class QuestionsController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :edit, :update, :create, :destroy]
  before_action :correct_user,   only: [:show, :edit, :update, :destroy]

  # show a list of questions available for challenge
  def index
    option_show_solved = params[:show_solved] #parameter to specify filter option
    @question = Question.get_solved(current_user.id)
    @list_type = 'All public '
    render 'questions/index'
  end

  # show a list of user's own questions
  def manage
    @question = Question.where("user_id = ?", current_user.id).paginate(page: params[:page])
    @list_type = 'Your '
    render 'questions/index'
  end

  # show questions statistics
  def show
    @question = Question.find(params[:id])
  end

  # create a new question
  def new
    @question = Question.new
  end

  # edit an existing question
  def edit
    @question = Question.find(params[:id])
  end

  # create a question
  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "Questions created!"
       redirect_to manage_questions_path
    else
      render 'new'
    end
  end

  # update an existing question
  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      redirect_to action: :manage 
    else
      render 'edit'
    end
  end  

  # destroy an existing question
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

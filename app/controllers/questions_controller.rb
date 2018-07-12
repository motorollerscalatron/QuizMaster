require 'will_paginate/array'

class QuestionsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :create, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index

    option_show_solved = params[:show_solved] #parameter to specify filter option

    @question_public = Question.where("is_public = ?", 't') 
    @my_challenge_question = Challenge.select("question_id").where("user_id = ? and result = ?", current_user.id, 't')
    @my_challenge_question_ids = @my_challenge_question.distinct.pluck("question_id")

    @question_public_filtered = Array.new

    for q in @question_public do
       @question_public_filtered.push(q) unless @my_challenge_question_ids.include?(q.id) 
    end     

    @question = @question_public_filtered.paginate(page: params[:page])

    @list_type = 'All public '
    render 'questions/index'
  end

  def manage
    @question = Question.where("user_id = ?", current_user.id).paginate(page: params[:page])
    @list_type = 'Your '
   render 'questions/index'
  end

#  def show
#    @question = Question.find(params[:id])
#  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "Questions created!"
       redirect_to manage_questions_path
    else
      @feed_items = []
      render 'new'
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      redirect_to action: :manage 
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

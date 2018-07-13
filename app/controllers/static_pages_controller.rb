class StaticPagesController < ApplicationController

  # home screen, including all instructions
  def home
    if logged_in?
      @question   = current_user.questions.build
      @feed_items = current_user.feed.paginate(page: params[:page] )
    end
  end

  def help
  end

end

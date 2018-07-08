require 'test_helper'

class QuestionsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @question = questions(:mind_expander)
  end

  test "unsuccessful edit" do
    log_in_as(@user) 
    get edit_question_path(@question)
    assert_template 'questions/edit'
    patch question_path(@question), params: { question: {description: "", answer: "123"} }
    assert_template 'questions/edit'
  end
end

require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @question = questions(:mind_expander)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Question.count' do
      post questions_path, params: { question: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_question_path(@question)
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Question.count' do
      delete question_path(@question)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong question" do
    log_in_as(users(:michael))
    question = questions(:stranger)
    assert_no_difference 'Question.count' do
      delete question_path(question)
    end
    assert_redirected_to root_url
  end
end

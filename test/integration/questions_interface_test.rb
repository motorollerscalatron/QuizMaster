require 'test_helper'

class QuestionsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "question interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Question.count' do
      post questions_path, params: { question: { description: "" } }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    description = "Who invented the steam engine?"
    answer = "James Watt"
    assert_difference 'Question.count', 1 do
      post questions_path, params: { question: { description: description, answer: answer } }
    end
    assert_redirected_to manage_questions_path
    follow_redirect!
    assert_match description, response.body

    # Delete question
    get root_path
    assert_select 'a', text: 'delete'
    first_question = @user.questions.paginate(page: 1).first
    assert_difference 'Question.count', -1 do
      delete question_path(first_question)
    end

    # Visit different user (no delete links)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0

    # Find appropriate operation links in index & manage
    get questions_path 
    assert_select 'a', text: 'challenge this quiz'
    assert_select 'a', text: 'edit this quiz'

    get '/questions/manage' 
    assert_select 'a', text: 'challenge this quiz'
    assert_select 'a', text: 'edit this quiz'
  end
end

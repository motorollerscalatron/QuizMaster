require 'test_helper'
require 'challenges_helper'
class ChallengesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @challenge = challenges(:one)
    @question = questions(:mind_expander)
    @question_styled = questions(:styled)
    @question_not_public = questions(:mediocre)
  end

  test "should redirect when not logged in" do
    get new_challenge_path
    assert_redirected_to login_url
  end

  test "should redirect when question is not public" do
    log_in_as(users(:archer))
    get new_challenge_path, params: { question_id: @question_not_public.id }
    assert_redirected_to questions_url
  end 

  test "should not redirect when question is not public and it is owned by current user" do
    log_in_as(users(:michael))
    get new_challenge_path, params: { question_id: @question_not_public.id }
    assert_template 'challenges/new'
  end

  test "should get sanitized question description" do
    log_in_as(users(:michael))
    get new_challenge_path, params: { question_id: @question_styled.id }
    assert_template 'challenges/new'
    assert_select "div#question_description", "Question: bstrong"
    assert_select "strong", "strong"
  end

  test "should get the appropriate feedback when the posted answer is correct" do
    log_in_as(users(:archer))
    assert_difference 'Challenge.count', 1 do
      question_id = questions(:mind_expander).id
      post challenges_path, params: { challenge: { user_id: 1, question_id: question_id, my_answer: "feed your head" } }
      assert_select "title", "result | Quiz Master"
      assert_select "section#feedback", "Assessment: Right!" 
    end
  end

  test "should get the appropriate feedback when the posted answer is wrong "do
    log_in_as(users(:archer))
    assert_difference 'Challenge.count', 1 do
      question_id = questions(:mind_expander).id
      post challenges_path, params: { challenge: { user_id: 1, question_id: question_id, my_answer: "feed your foot" } }
      assert_select "title", "result | Quiz Master"
      assert_select "section#feedback", "Assessment: Oops..." 
    end
  end

  test "should get the appropriate feeback when the numeric answer is matched using string notation " do
    log_in_as(users(:archer))
    assert_difference 'Challenge.count', 1 do
      question_id = questions(:numeric).id
      post challenges_path, params: { challenge: { user_id: 1, question_id: question_id, my_answer: "thirty-two" } }
      assert_select "title", "result | Quiz Master"
      assert_select "section#feedback", "Assessment: Right!" 
    end
  end

end

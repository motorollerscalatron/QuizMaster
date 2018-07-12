require 'test_helper'

class ChallengesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @challenge = challenges(:one)
    @question = questions(:mind_expander)
  end

  test "should redirect when not logged in" do
    get new_challenge_path
    assert_redirected_to login_url
  end

  test "should get the appropriate feedback when the posted answer is correct" do
    log_in_as(users(:michael))
    assert_difference 'Challenge.count', 1 do
      question_id = questions(:mind_expander).id
      post challenges_path, params: { challenge: { user_id: 1, question_id: question_id, my_answer: "feed your head" } }
      assert_select "title", "result | Quiz Master"
    end
  end

  test "should get the appropriate feedback when the posted answer is wrong "do
    log_in_as(users(:michael))
    assert_difference 'Challenge.count', 1 do
      question_id = questions(:mind_expander).id
      post challenges_path, params: { challenge: { user_id: 1, question_id: question_id, my_answer: "feed your foot" } }
      assert_select "title", "result | Quiz Master"
    end
  end

  test "should get the appropriate feeback when the numeric answer is matched using string notation " do
  end

end

require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase

  def setup
    @challenge = Challenge.new(user_id: users(:archer).id,
                               question_id: questions(:mind_expander).id,
                               my_answer: 'abc'
                              )
  end

  test "should be valid" do
    assert @challenge.valid?
  end

  test "should require a user_id" do
    @challenge.user_id = nil
    assert_not @challenge.valid?
  end

  test "should require a question_id" do
    @challenge.question_id = nil
    assert_not @challenge.valid?
  end

  test "should require a my_answer" do
    @challenge.my_answer = nil
    assert_not @challenge.valid?
  end
end

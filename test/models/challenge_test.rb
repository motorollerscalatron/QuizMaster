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

  #matchAnswer
  test "should return false if the answer is not matched" do
    @challenge.my_answer = 'hello'
    assert_equal false, @challenge.matchAnswer(@challenge.my_answer)
  end

  test "should tolerate trailing spaces in submitted answer" do
    @challenge.my_answer = 'feed your head '
    assert_equal true, @challenge.matchAnswer(@challenge.my_answer)
  end

  test "should interpret number in string notation in submitted answer" do
    @challenge.question_id = questions(:numeric).id
    @challenge.my_answer = 'thirty-two '
    assert_equal true, @challenge.matchAnswer(@challenge.my_answer)
  end

  test "should interpret number in one word string notation in submitted answer" do
    @challenge.question_id = questions(:numeric_one_word).id
    @challenge.my_answer = 'fifty'
    assert_equal true, @challenge.matchAnswer(@challenge.my_answer)
  end

  test "should interpret number one word string notation in submitted answer" do
    @challenge.question_id = questions(:numeric_one_word).id
    @challenge.my_answer = 'fifty'
    assert_equal true, @challenge.matchAnswer(@challenge.my_answer)
  end

  test "should not interpret number if characters other than 0-9 are included" do
    @challenge.question_id = questions(:numeric_minus).id
    @challenge.my_answer = 'minus ninety'
    assert_equal false, @challenge.matchAnswer(@challenge.my_answer)
  end

end

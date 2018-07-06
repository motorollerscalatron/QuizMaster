require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @question = @user.questions.build(description: "Lorem ipsum", user_id: @user.id)
  end

  test "should be valid" do
    assert @question.valid?
  end

  test "user id should be present" do
    @question.user_id = nil
    assert_not @question.valid?
  end

  test "description should be present" do
    @question.description = "   "
    assert_not @question.valid?
  end

  test "content should be at most 255 characters" do
    @question.description = "a" * 256
    assert_not @question.valid?
  end

  test "order should be most recent first" do
    assert_equal questions(:most_recent), Question.first
  end
end
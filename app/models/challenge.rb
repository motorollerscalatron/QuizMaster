class Challenge < ApplicationRecord

  FEEDBACK_CORRECT   = 'Right!' 
  FEEDBACK_INCORRECT = 'Oops try again ...'
  FEEDBACK_CLOSE     = 'Very close ...'

  attr_accessor :my_answer

  belongs_to :user,     class_name: "User"
  belongs_to :question, class_name: "Question"
  validates :user_id,     presence: true
  validates :question_id, presence: true
  validates :my_answer,   presence: true

  def matchAnswer(string)

    conv_correct = self.question.answer.squish
    conv_string = string.squish
    
    if conv_correct =~ /^[0-9]+$/
      conv_correct = to_en(conv_correct.to_i)
    end

    if conv_string =~ /^[0-9]+$/
      conv_string = to_en(conv_string.to_i)
    end

    return !!( conv_correct == conv_string )
  end

  private  
    def to_en(number)
      return number.to_s unless number.is_a?(Integer)
      case number
      when 1
        "one"
      when 2
        "two"
      when 3
        "three"
      when 4
        "four"
      when 5
        "five"
      when 6
        "six"
      when 7
        "seven"
      when 8
        "eight"
      when 9
        "nine"
      when 10
        "ten"
      when 11
        "eleven"
      when 12
        "twelve"
      when 13
        "thirteen"
      when 14
        "fourteen"
      when 15
        "fifteen"
      when 16
        "sixteen"
      when 17
        "seventeen"
      when 18
        "eighteen"
      when 19
        "nineteen"
      when 20
        "twenty"
      when 30
        "thirty"
      when 40
        "forty"
      when 50
        "fifty"
      when 60
        "sixty"
      when 70
        "seventy"
      when 80
        "eighty"
      when 90
        "ninety"
      when 21 .. 99
        x_one = number % 10
        x_ten = number - x_one
        to_en(x_ten) + "-" + to_en(x_one)
      when 100 .. 999
        front_num = number / 100
        rear_num = number % 100
        if rear_num == 0
          to_en(front_num) + " hundred"
        else
          to_en(front_num) + " hundred and " + to_en(rear_num)
        end
      when 1e3 .. 999999
        front_num = number / 1000
        rear_num = number % 1000
        if rear_num == 0
          to_en(front_num) + " thousand"
        else
          to_en(front_num) + " thousand and " + to_en(rear_num)
        end
      else
        number.to_s
      end
    end

end

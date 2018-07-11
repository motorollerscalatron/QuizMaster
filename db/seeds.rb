# Users
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# Questions
users = User.order(:created_at).take(6)
50.times do
  description = Faker::Lorem.sentence(5)
  answer = Faker::Lorem.word
  is_public = Faker::Boolean.boolean(0.5)
  users.each { |user| user.questions.create!(description: description, answer: answer, is_public: is_public) }
end

# Challenges
users = User.all
user = users.first
questions = Question.all
question = questions.where("is_public = ?", 't').first
challengers = users[2..10]
my_answer = 'some aonswer'
challengers.each do |challenger|
result = Faker::Boolean.boolean(0.5)
    user.challenges.create!(user: challenger,
                            question: question,
                            result: result,
                            my_answer: my_answer)
end

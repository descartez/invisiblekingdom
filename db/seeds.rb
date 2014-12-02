User.create!(username: "dez", email: "dez@dez.com", password: "password")
10.times do
  new_user = User.create!(username: Faker::Internet.user_name, email: Faker::Internet.email, password: "password")
  15.times do
    new_story = Story.create!(longitude: Faker::Number.number(2), lattitude: Faker::Number.number(2))
    new_story.story_maker
    new_user.stories << new_story
  end
end


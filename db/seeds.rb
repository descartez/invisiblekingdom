10.times do
  new_user = User.create!(username: Faker::Internet.user_name, email: Faker::Internet.email, password: "password")
  15.times do
    new_story = Story.create!
    new_story.story_maker
    new_user.stories << new_story
  end
end


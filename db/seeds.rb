10.times do
  new_user = User.create!(username: Faker::Internet.user_name, email: Faker::Internet.email, password: "password")
  15.times do
    stories = ["The Emperor decreed, let there be a mighty gate, gold and wide.", "Shades and echoes of shades.", "Keep an eye out for fairies at this time of day. Just look with the corner of your eyes.", "Breathe.", "When you ask to enter, make sure to say 'please'", "Make sure to listen to Old Trees.", "You stand on many hills."]
    new_story = Story.create!
    new_story.story_maker
    new_user.stories << new_story
  end
end


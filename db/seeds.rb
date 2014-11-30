10.times do
  User.new(username: Faker::Internet.user_name, email: Faker::Internet.email, password: "password")
end

15.times do
  stories = ["The Emperor decreed, let there be a mighty gate, gold and wide.", "Shades and echoes of shades.", "Keep an eye out for fairies at this time of day. Just look with the corner of your eyes.", "Breathe.", "When you ask to enter, make sure to say 'please'", "Make sure to listen to Old Trees.", "You stand on many hills."]
  Story.new(content: stories.shuffle.sample, user_id: rand(1..10))
end

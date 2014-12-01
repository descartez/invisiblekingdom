get '/' do
  erb :index
end

get '/stories' do
  # @user = User.find(sessions[:user_id])
  # @stories = Story.find_by(user_id: @user)
  @stories = Story.all
  erb :stories
end

get '/sessions' do
  erb :login
end

post '/sessions' do

end

get '/' do
  # @user = current_user
  erb :index
end

get '/stories' do
  if logged_in?
    @user = current_user
    @stories = @user.stories.reverse
    erb :stories
  else
    redirect '/'
  end
end

get '/stories/new' do
  new_story = Story.create!(longitude: Faker::Number.number(2), lattitude: Faker::Number.number(2))
  new_story.story_maker
  current_user.stories << new_story
  redirect '/stories'
end

get '/sessions' do
  if logged_in?
    redirect '/stories'
  else
    erb :login
  end
end

post '/sessions' do
  @valid_user = User.find_by_email(params[:email])
  if @valid_user.nil?
    redirect '/sessions'
  elsif @valid_user.authenticate(params[:password])
    session[:user_id] = @valid_user.id
    redirect '/stories'
  end
end

delete '/sessions/:id' do
  session.clear
  redirect '/'
end

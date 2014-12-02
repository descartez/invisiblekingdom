get '/' do
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

post '/stories' do
  if request.xhr?
    new_story = Story.create!(longitude: params[:longitude], lattitude: params[:lattitude])
    new_story.story_maker
    current_user.stories << new_story
    content_type :json
    new_story.to_json
  end
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

Dotenv.load

after do
  ActiveRecord::Base.connection.close
end

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
    new_story = Story.create!(longitude: params[:longitude], latitude: params[:latitude])
    new_story.story_maker
    current_user.stories << new_story
    content_type :json
    new_story.to_json
  end
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  # I MADE A HELPER METHOD USE IT FOOL
  @valid_user = User.create(email: params[:email], password: params[:password])
  @valid_user.stories.create(content: "Welcome. Explore by activating the Eye.", longitude: 0, latitude: 0)
  redirect '/sessions'
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
    make_session(@valid_user.id)
    redirect '/stories'
  end
end

delete '/sessions/:id' do
  session.clear
  redirect '/'
end

get '/oauth/google' do
  redirect "https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=#{ENV["CLIENT_ID"]}&redirect_uri=http://localhost:9393/oauth/google/logged_in&scope=https://www.googleapis.com/auth/plus.profile.emails.read&state=12345&approval_prompt=force"
end

get '/oauth/google/logged_in' do
token_response = HTTParty.post("https://accounts.google.com/o/oauth2/token",
                                body: {
                                      code: params[:code],
                                      client_id: ENV["CLIENT_ID"],
                                      client_secret: ENV["CLIENT_SECRET"],
                                      redirect_uri: "http://localhost:9393/oauth/google/logged_in",
                                      grant_type: "authorization_code"
                                })


  google_plus_response = HTTParty.get("https://www.googleapis.com/plus/v1/people/me?access_token=#{token_response["access_token"]}")
  @user = User.find_or_create_by(email: "#{google_plus_response['emails'][0]['value']}")
  @stories = @user.stories
  make_session(@user.id)

  redirect '/stories'
end

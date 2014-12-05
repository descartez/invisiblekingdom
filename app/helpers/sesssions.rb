helpers do
  def current_user
    User.find(session[:user_id])
  end

  def logged_in?
    !!(session[:user_id])
  end

  def make_session(id)
    session[:user_id] = id
  end

  def make_user
    @valid_user = User.create(email: params[:email], password: params[:password])
    @valid_user.stories.create(content: "Welcome. Explore by activating the Eye.", longitude: 0, latitude: 0)
  end
end

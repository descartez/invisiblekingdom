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

  def make_user(email, password)
    @valid_user = User.create(email: email, password: password)
    @valid_user.stories.create(content: "Welcome. Explore by activating the Eye.", longitude: 0, latitude: 0)
  end

  def check_guest_login
    @guest = User.find_by_email('guest@guest.com')
    if !!(@guest)
      @guest.authenticate('guest')
      @guest.stories.create(content: "Welcome. Explore by activating the Eye.", longitude: 0, latitude: 0)
      make_session(@guest.id)
      redirect '/stories'
    else
      @guest_user = User.create(email: 'guest@guest.com', password: 'guest')
      @guest_user.stories.create(content: "Welcome. Explore by activating the Eye.", longitude: 0, latitude: 0)
      check_guest_login
    end
  end

  def check_guest_logout
    guest = User.find_by_email('guest@guest.com')
    if session[:user_id] == guest.id
      p 'wat'
      guest.stories.delete_all
    end
  end

end

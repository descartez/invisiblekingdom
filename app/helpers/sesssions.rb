helpers do
  def current_user
    User.find(session[:user_id])
  end

  def logged_in?
    !!(session[:user_id])
  end

  def make_intro(user)
    user.stories.create(content: "Welcome. Explore by activating the Eye.", longitude: 0, latitude: 0)
  end

  def make_session(id)
    session[:user_id] = id
  end

  def make_user(email, password)
    @valid_user = User.create(email: email, password: password)
    make_intro(@valid_user)
  end

  def check_guest_login
    @guest = User.find_by_email('guest@guest.com')
    if !!(@guest)
      @guest.authenticate('guest')
      make_intro(@guest)
      make_session(@guest.id)
      redirect '/stories'
    else
      @guest_user = User.create(email: 'guest@guest.com', password: 'guest')
      make_intro(@guest_user)
      check_guest_login
    end
  end

  def check_guest_logout
    guest = User.find_by_email('guest@guest.com')
    if session[:user_id] == guest.id
      guest.stories.delete_all
    end
  end

end

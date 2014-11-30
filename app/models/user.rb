class User < ActiveRecord::Base
  has_many :stories

  include BCrypt
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(possible_password)
    Password.new(self.password_hash) == possible_password ? true : false
  end
end

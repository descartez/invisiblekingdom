class User < ActiveRecord::Base

  has_many :stories

include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.new(new_password)
    self.password_hash = @password
  end
end

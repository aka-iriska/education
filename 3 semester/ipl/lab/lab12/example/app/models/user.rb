class User < ActiveRecord::Base
  # rails 3: attr_accessible :email, :name, :password

  def has_password?(submitted_password)
    password == submitted_password
  end
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end
end

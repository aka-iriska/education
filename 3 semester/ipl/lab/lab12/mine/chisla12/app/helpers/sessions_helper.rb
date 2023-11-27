module SessionsHelper
  def sign_in(user)
    #cookies.permanent.signed[:remember_token] = [user.id]
    session[:current_user_id] = user.id
    self.current_user = user
  end

  def sign_out
    #cookies.delete(:remember_token)
    session[:current_user_id] = nil
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end
  def signed_in?
    !current_user.nil?
  end
  def current_user
    @_current_user ||= session[:current_user_id] &&
      User.find_by_id(session[:current_user_id])
  end
end

module SessionsHelper

  # Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns current user (if there's one)
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

end

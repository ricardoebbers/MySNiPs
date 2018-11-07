class ApplicationController < ActionController::Base
  # Make the current_user method available to views also, not just controllers:
  helper_method :current_user

  # Define the current_user method:
  def current_user
    # Look up the current user based on user_id in the session cookie:
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # authroize method redirects user to login page if not logged in:
  def authorize
    if current_user.nil?
      redirect_to login_path, alert: 'You must be logged in to access this page.' if current_user.nil?
      false
    else
      true
    end
  end
end

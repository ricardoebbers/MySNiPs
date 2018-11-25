class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    if session[:user_id]
      redirect_to :report_index
    end
  end

  def create
    user = User.find_by(identifier: params[:login][:identifier].downcase)

    # Verify user exists in db and run has_secure_password's .authenticate()
    # method to see if the password submitted on the login form was correct:
    if user && user.authenticate(params[:login][:password])
      # Save the user.id in that user's session cookie:
      if !user.last_login
        flash[:notice] = "Termos de Uso"
      end
      user.last_login = Time.now
      user.save
      session[:user_id] = user.id.to_s
      redirect_to :report_index
    else
      # if email or password incorrect, re-render login page:
      flash.now.alert = "Incorrect email or password, try again."
      render :new
    end
  end

  def destroy
    # delete the saved user_id key/value from the cookie:
    session.delete(:user_id)
    redirect_to root_path, notice: "Logged out!"
  end
end

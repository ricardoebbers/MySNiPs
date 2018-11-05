class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    Role.create(role_name: "usuario_final")
    role = Role.find_by(role_name: "usuario_final")
    @user = User.new(user_params)
    @user.role_id = role.id
    if @user.save
      # If user saves in the db successfully:
      flash[:notice] = "Account created successfully!"
      redirect_to root_path
    else
      # If user fails model validation - probably a bad password or duplicate email:
      flash.now.alert = "Oops, couldn't create account. Please make sure you are using a valid data and try again."
      render :new
    end
  end

  def authorization_valid?
    return false unless session[:user_id]
    current = User.find(session[:user_id])
    return false if current.nil?
    role = Role.find(current.role_id)
    return false if role.nil?

    case role.role_name
    when "admin" then true
    when "laboratorio" then true
    else false
    end
  end

  # GET /users/
  def index
    if authorization_valid?
      @users = User.all
      json_response(@users)
    else
      redirect_to root_path
    end
  end

  # GET /users/:id
  def show
    if authorization_valid?
      @user = User.find(params[:id])
      json_response(@user)
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    # strong parameters - whitelist of allowed fields #=> permit(:name, :email, ...)
    # that can be submitted by a form to the user model #=> require(:user)
    params.require(:user).permit(:identifier, :password)
  end
end

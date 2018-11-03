class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    Role.create({:role_name => "usuario_final"})
    role = Role.find_by(:role_name => "usuario_final")
    @user = User.new(user_params)
    @user.role_id = role.id
    if @user.save
      # If user saves in the db successfully:
      flash[:notice] = "Account created successfully!"
      redirect_to root_path
    else
      # If user fails model validation - probably a bad password or duplicate email:
      flash.now.alert = "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
      render :new
    end
  end

private

  def user_params
    # strong parameters - whitelist of allowed fields #=> permit(:name, :email, ...)
    # that can be submitted by a form to the user model #=> require(:user)
    params.require(:user).permit(:identifier, :password)
  end
end

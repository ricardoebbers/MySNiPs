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

    @current_user = User.find(session[:user_id])
    return false if @current_user.nil?

    @role = Role.find(@current_user.role_id)
    return false if @role.nil?

    case @role.role_name
    when "admin" then true
    when "laboratorio" then true
    else false
    end
  end

  # GET /users/
  def index
    # Common or unlloged users can't see other users
    return json_response(error: "Invalid credentials") unless authorization_valid?

    # Admins can see all users
    return json_response(User.all) if @role.role_name == "admin"

    # While labs can only see their users
    common_role_id = Role.find_by(role_name: "usuario_final").id
    @users = User .where("identifier LIKE (?) AND role_id = (?)", "#{@current_user.identifier}%", common_role_id.to_s)
                  .select("id, identifier, password, created_at, last_login")
    json_response(@users)
  end

  # GET /users/:id
  def show
    # Common or unlloged users can't see other users
    return json_response(message: "Invalid credentials") unless authorization_valid?

    # Labs can only see their own users
    @user = User.select("id, identifier, password, created_at, last_login").find(params[:id])
    unless @user.nil?
      if @role.role_name == "laboratorio"
        return json_response(message: "No access") unless @user.identifier.start_with? @current_user.identifier
      end
    end
    json_response(@user)
  end

  private

  def user_params
    # strong parameters - whitelist of allowed fields #=> permit(:name, :email, ...)
    # that can be submitted by a form to the user model #=> require(:user)
    params.require(:user).permit(:identifier, :password)
  end
end

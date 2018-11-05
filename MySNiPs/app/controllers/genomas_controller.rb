class GenomasController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @genoma = Genoma.new
  end

  def create
    # Only labs and admins can post genomas
    return json_response(message: "Invalid credentials") unless authorization_valid?

    return json_response(message: "Invalid parameters") unless params.has_key? :id

    Role.create(role_name: "usuario_final")
    role = Role.find_by(role_name: "usuario_final")
    return json_response(message: "Internal role error") if role.nil?

    # TO-DO
    password = generate_password

    # Labs can't create users on other labs' numbers
    params[:id] = @current_user.identifier + params[:id] unless @role.role_name == "admin"
    @user = User.new(identifier: params[:id], password: password, role_id: role.id)
    return json_response(message: @user.errors.message) unless @user.valid?

    @user.save

    # Genomas always start with Status 1: queue
    @genoma = Genoma.new(user_id: @user.id, status: 1)
    return json_response(message: @user.errors.message) unless @genoma.valid?

    @genoma.save
  end

  def generate_password
    "123"
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

  # GET /genomas/
  def index
    # Common or unlloged users can't see genomas
    return json_response(error: "Invalid credentials") unless authorization_valid?

    # Admins can see all genomas
    return json_response(User.all) if @role.role_name == "admin"

    # While labs can only see their users' genomas
    common_role_id = Role.find_by(role_name: "usuario_final").id
    @genomas = Genoma .joins(:user)
                      .where("identifier LIKE (?) AND role_id = (?)", "#{@current_user.identifier}%", common_role_id.to_s)
                      .select("identifier, status, genomas.created_at, genomas.updated_at")

    json_response(@genomas)
  end

  # GET /genomas/:id
  def show
    # Common or unlloged users can't see genomas
    return json_response(message: "Invalid credentials") unless authorization_valid?

    # Labs can only see their own users' genomas
    params[:id] = @current_user.identifier + params[:id] unless @role.role_name == "admin"
    @genoma = User.joins(:genoma)
                  .select("identifier, status, genomas.created_at, genomas.updated_at")
                  .find_by(identifier: params[:id])
    json_response(@genoma)
  end

  private

  def genoma_params
    params.require(:id, :csv)
  end
end

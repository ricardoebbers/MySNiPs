module Api
  module V1
    class GenomasController < ApiController
      def new
        @genoma = Genoma.new
      end

      def create
        # Only labs and admins can post genomas
        return json_response(error: "Invalid credentials") unless authority_valid?

        return json_response(error: "Invalid parameters") unless params.has_key? :identifier

        Role.create(role_name: "usuario_final")
        role = Role.find_by(role_name: "usuario_final")
        return json_response(error: "Internal role error") if role.nil?

        # TO-DO
        password = generate_password
        # Labs can't create users on other labs' numbers
        params[:identifier] = @current_api_user.identifier + params[:identifier] unless @role.role_name == "admin"
        @user = User.new(identifier: params[:identifier], password: password, role_id: role.id)
        @user.pass = password
        return json_response(error: @user.errors.messages) unless @user.valid?

        @user.save

        # Genomas always start with Status 1: queue
        @genoma = Genoma.new(user_id: @user.id, status: 1)
        return json_response(error: @user.errors.message) unless @genoma.valid?

        @genoma.save
        json_response(message: "Success", user: @user.to_json_view, genoma: @genoma.to_json_view)
      end

      def generate_password
        "123"
      end

      # GET /genomas/
      def index(last=false)
        # Common or unlloged users can't see genomas
        return json_response(error: "Invalid credentials") unless authority_valid?

        # Admins can see all genomas
        return json_response(User.all) if @role.role_name == "admin"

        # While labs can only see their users' genomas
        common_role_id = Role.find_by(role_name: "usuario_final").id
        @genomas = Genoma .joins(:user)
                          .where("identifier LIKE (?) AND role_id = (?)", "#{@current_api_user.identifier}%", common_role_id.to_s)
                          .select("identifier, status, genomas.created_at, genomas.updated_at")
                          .order("created_at ASC")

        # Called by show_latest with /genomas/last
        @genomas = @genomas.last if last
        json_response(@genomas || {message: "Nothing found"})
      end

      # GET /genoma/:id
      def show
        # Common or unlloged users can't see genomas
        return json_response(error: "Invalid credentials") unless authority_valid?

        # Labs can only see their own users' genomas
        params[:identifier] = @current_api_user.identifier + params[:identifier] unless @role.role_name == "admin"
        @genoma = User.joins(:genoma)
                      .select("identifier, status, genomas.created_at, genomas.updated_at")
                      .find_by(identifier: params[:identifier])
        json_response(@genoma || {message: "Nothing found"})
      end

      # GET /genoma/last
      def show_latest
        # Orders the index by Created_At and returns the last
        index true
      end

      private

      def genoma_params
        params.require(:id, :csv)
      end
    end
  end
end

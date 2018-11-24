module Api
  module V1
    class GenomasController < ApiController
      def new
        @genoma = Genoma.new
      end

      def create
        # Only labs and admins can post genomas
        return json_response({error: "Invalid credentials"}, 401) unless authority_valid?
        return json_response({error: "Invalid parameters"}, 400) unless params.has_key? :identifier

        raw = params[:raw_file].freeze if params.has_key?(:raw_file) && params[:raw_file].is_a?(String)
        params[:raw_file] = nil
        return json_response({error: "No file"}, 400) if raw.nil?

        user_error = prepare_user_for params[:identifier]
        return user_error unless user_error.nil?

        return json_response({error: "Error while creating User"}, 500) if @user.nil?

        # Genomas always start with Status 1: queue
        genoma = Genoma.new(user_id: @user.id, status: 1)
        unless genoma.valid?
          raw = nil
          params = nil
          @user.destroy
          errors = genoma.errors.messages
          genoma = nil
          @users = nil
          return json_response({error: errors}, 400)
        end

        genoma.save

        genoma_view = genoma.to_json_view
        user_view = @user.to_json_view
        @user = nil

        GC.start(full_mark: true, immediate_sweep: true)

        Thread.new do
          m = MatchMaker.new
          m.make_matches_for(genoma, raw)
        end

        json_response(message: "Success, the genoma is being read", user: user_view, genoma: genoma_view)
      end

      def prepare_user_for identifier
        # Every user created is a final user
        role = Role.find_by(role_name: "usuario_final")
        return json_response({error: "Internal role error"}, 500) if role.nil?

        identifier = User.format_identifier_for @current_api_user.identifier, identifier
        password = User.generate_random_password

        # Labs can't create users on other labs' numbers
        @user = User.new(identifier: identifier, password: password, pass: password, role_id: role.id)
        return json_response({error: @user.errors.messages}, 400) unless @user.valid?

        @user.save
        nil
      end

      # GET /genomas/
      def index(last=false)
        # Common or not logged in users can't see genomas
        return json_response({error: "Invalid credentials"}, 401) unless authority_valid?

        # Admins can see all genomas
        return json_response(User.all) if @role.role_name == "admin"

        # While labs can only see their users' genomas
        common_role_id = Role.find_by(role_name: "usuario_final").id
        @genomas = Genoma .joins(:user)
                          .where("identifier LIKE (?) AND role_id = (?)", "#{@current_api_user.identifier}%", common_role_id.to_s)
                          .select("identifier, status, genomas.updated_at")
                          .order("genomas.created_at ASC")

        # Called by show_latest with /genomas/last
        @genomas = @genomas.last if last

        return json_response({message: "Nothing found"}, 404) if @genomas.nil?

        json_response(@genomas)
      end

      # GET /genoma/:id
      def show
        # Common or not logged in users can't see genomas
        return json_response({error: "Invalid credentials"}, 401) unless authority_valid?

        # Labs can only see their own users
        # Admin can see all genomas, but must type the entire identifier
        identifier = User.format_identifier_for @current_api_user.identifier, params[:identifier]

        @genoma = User.joins(:genoma)
                      .select("identifier, status, genomas.created_at, genomas.updated_at")
                      .find_by(identifier: identifier)

        return json_response({message: "Nothing found"}, 404) if @genoma.nil?

        json_response(@genoma)
      end

      # GET /genoma/last
      def show_latest
        # Orders the index by Created_At and returns the last
        index true
      end

      private

      def genoma_params
        params.require(:identifier, :raw_file)
      end
    end
  end
end

module Api
  module V1
    class GenomasController < ApiController
      def create
        # Only labs and admins can post genomas
        return json_response({error: "Invalid credentials"}, 401) unless authority_valid?
        return json_response({error: "Invalid parameters"}, 400) unless params.has_key? :identifier
        raw = Base64.decode64(params[:raw_file]).freeze if params.has_key?(:raw_file) && params[:raw_file].is_a?(String)
        params[:raw_file] = nil
        return json_response({error: "No file"}, 400) if raw.nil?

        # Prepare user
        role = Role.find_by(role_name: "usuario_final")
        return json_response({error: "Internal role error"}, 500) if role.nil?

        role_id = role.id
        role = nil

        identifier = User.format_identifier_for current_api_user.identifier, params[:identifier]
        password = User.generate_random_password

        # Labs can't create users on other labs' numbers
        user = User.new(identifier: identifier, password: password, pass: password, role_id: role_id)
        return json_response({error: user.errors.messages}, 400) unless user.valid?

        user.save
        # End of Prepare user

        return json_response({error: "Error while creating User"}, 500) if user.nil?

        genoma = Genoma.new(user_id: user.id)
        unless genoma.valid?
          raw = nil
          params = nil
          user.destroy
          user = nil
          errors = genoma.errors.messages
          genoma = nil
          return json_response({error: errors}, 400)
        end

        genoma.save

        genoma_view = genoma.to_json_view
        user_view = user.to_json_view
        user = nil

        Thread.new do
          Rails.application.executor.wrap do
            MatchMaker.make_matches_for(genoma, raw)
          end
        end

        json_response(message: "Success, the genoma is being read", user: user_view, genoma: genoma_view)
      end
      # GET /genomas/
      def index(last=false)
        # Common or not logged in users can't see genomas
        return json_response({error: "Invalid credentials"}, 401) unless authority_valid?

        # Admins can see all genomas
        return json_response(User.all) if current_api_user.identifier == "000"

        # While labs can only see their users' genomas
        common_role_id = Role.find_by(role_name: "usuario_final").id
        genomas = Genoma .joins(:user)
                          .where("identifier LIKE (?) AND role_id = (?)", "#{current_api_user.identifier}%", common_role_id.to_s)
                          .select("identifier, status, genomas.updated_at")
                          .order("genomas.created_at ASC")

        # Called by show_latest with /genomas/last
        genomas = genomas.last if last

        return json_response({message: "Nothing found"}, 404) if genomas.nil?

        json_response(genomas)
      end

      # GET /genoma/:id
      def show
        # Common or not logged in users can't see genomas
        return json_response({error: "Invalid credentials"}, 401) unless authority_valid?

        # Labs can only see their own users
        # Admin can see all genomas, but must type the entire identifier
        identifier = User.format_identifier_for current_api_user.identifier, params[:identifier]

        genoma = User.joins(:genoma)
                      .select("identifier, status, genomas.created_at, genomas.updated_at")
                      .find_by(identifier: identifier)

        return json_response({message: "Nothing found"}, 404) if genoma.nil?

        json_response(genoma)
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

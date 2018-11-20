module Api
  module V1
    class GenomasController < ApiController
      PASSWORD_LENGTH = 6

      def new
        @genoma = Genoma.new
      end

      def create
        # Only labs and admins can post genomas
        return json_response({error: "Invalid credentials"}, 401) unless authority_valid?
        return json_response({error: "Invalid parameters"}, 400) unless params.has_key? :identifier

        # Every user created is a final user
        role = Role.find_by(role_name: "usuario_final")
        return json_response({error: "Internal role error"}, 500) if role.nil?

        # Checks if the idenfifier is valid
        return json_response({error: "Identifier should be integer"}, 401) unless just_numbers? params[:identifier]
        return json_response({error: "Max Idenfitifier length is #{IDENTIFIER_LENGTH}"}, 401) unless right_size? params[:identifier]

        identifier = format_identifier_for @current_api_user.identifier, params[:identifier]
        password = generate_random_password

        # Labs can't create users on other labs' numbers
        @user = User.new(identifier: identifier, password: password, role_id: role.id)
        @user.pass = password
        return json_response({error: @user.errors.messages}, 400) unless @user.valid?

        @user.save

        # Genomas always start with Status 1: queue
        @genoma = Genoma.new(user_id: @user.id, status: 1, raw_file: params[:raw_file])
        unless @genoma.valid?
          @user.destroy
          return json_response({error: @user.errors.message}, 400)
        end

        @genoma.save
        json_response(message: "Success", user: @user.to_json_view, genoma: @genoma.to_json_view)
      end

      def just_numbers?(ident)
        ident !~ /\D/
      end

      def right_size?(ident)
        ident.to_s.length <= IDENTIFIER_LENGTH
      end

      def generate_random_password
        # Generates a random string of 6 characters with numbers and lowcase letters
        numbers_and_letters = ("a".."z").to_a.size + (0..9).size # 36
        rand(numbers_and_letters**PASSWORD_LENGTH - 1).to_s(numbers_and_letters)
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
        identifier = format_identifier_for @current_api_user.identifier, params[:identifier]

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

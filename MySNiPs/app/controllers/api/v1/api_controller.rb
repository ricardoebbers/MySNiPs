module Api
  module V1
    class ApiController < ApplicationController
      include Response
      include ExceptionHandler
      skip_before_action :verify_authenticity_token
      before_action :authenticate_request

      attr_reader :current_api_user

      def authority_valid?
        return false if @current_api_user.nil?

        @role = Role.find(@current_api_user.role_id)
        return false if @role.nil?

        case @role.role_name
        when "admin" then true
        when "laboratorio" then true
        else false
        end
      end

      IDENTIFIER_LENGTH = 7
      # Transforms the id_number into a 7 digits string justified to the right with zeros
      # Then merges it with the lab identifier
      # Example: 001, 123 -> "0010000123"
      def format_identifier_for lab_identifier, id_number
        return id_number if lab_identifier == "admin"

        lab_identifier + id_number.to_s.rjust(IDENTIFIER_LENGTH, "0")
      end

      private

      def authenticate_request
        @current_api_user = AuthorizeApiRequest.call(request.headers).result
        puts @current_api_user.inspect
        render json: {error: "Not Authorized"}, status: :unauthorized unless @current_api_user
      end
    end
  end
end

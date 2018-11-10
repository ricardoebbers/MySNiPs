module Api
  module V1
    class AuthenticationController < ApplicationController
      protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }

      def authenticate
        command = AuthenticateUser.call(params[:identifier], params[:password])
        if command.success?
          render json: {auth_token: command.result}, status: :ok
        else
          render json: {error: command.errors}, status: :unauthorized
        end
      end
    end
  end
end

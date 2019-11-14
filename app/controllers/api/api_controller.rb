# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    protect_from_forgery with: :null_session

    def api_show(collection, serializer)
      object = collection.find_by(id: params[:id])
      if object
        render json: object, serializer: serializer if object
      else
        render json: { error: 'not_found' }, status: :not_found
      end
    end

    def verify_auth_token
      token = request.headers['token']
      @user = User.find_by(auth_token: token)
      render json: { error: 'user_not_found' }, status: :not_found unless @user
    end
  end
end

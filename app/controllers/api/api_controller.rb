# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    def api_show(collection, serializer)
      object = collection.find_by(id: params[:id])
      if object
        render json: object, serializer: serializer if object
      else
        render json: { error: 'not_found' }, status: :not_found
      end
    end

    def api_destroy(collection)
      object = collection.find_by(id: params[:id])
      if object
        object.destroy
        render json: { status: 'ok' }, status: :ok
      else
        render json: { error: 'not_found' }, status: :bad_request
      end
    end
  end
end

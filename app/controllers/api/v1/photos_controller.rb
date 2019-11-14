# frozen_string_literal: true

module Api
  module V1
    class PhotosController < ApiController
      before_action :verify_auth_token, only: %i[create destroy]

      def index
        search = params[:search] || ''
        sort = params[:sort] || 'likes_count'
        photos = Photo.approved.search(search).reorder("#{sort} DESC").page(params[:page]).per(5)
        render json: photos, each_serializer: PhotoSerializer
      end

      def show
        api_show(Photo, PhotoSerializer)
      end

      def create
        outcome = Photos::Create.run(photo_params)
        if outcome.valid?
          render json: outcome.result, status: :ok
        else
          render json: outcome.errors, status: :unprocessable_entity
        end
      end

      def destroy
        photo = Photo.find_by(id: params[:id])
        if photo
          if photo.user_id == @user.id
            photo.destroy
            render json: { status: 'ok' }, status: :ok
          else
            render json: { status: 'forbidden' }, status: :forbidden
          end
        else
          render json: { error: 'not_found' }, status: :bad_request
        end
      end

      private

      def photo_params
        {
          title: params[:title],
          location: params[:location],
          photo_type: 'file',
          photo_file: params[:photo],
          user: @user
        }
      end
    end
  end
end

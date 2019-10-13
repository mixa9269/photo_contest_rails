# frozen_string_literal: true

module Api
  module V1
    class PhotosController < ApiController
      def index
        search = params[:search] || ''
        sort = params[:sort] || 'likes_count'
        photos = Photo.approved.search(search).reorder("#{sort} DESC").page(params[:page]).per(5)
        render json: photos, each_serializer: PhotoSerializer
      end

      def show
        api_show(Photo, PhotoSerializer)
      end

      private

      def photo_params
        {
          title: params[:title],
          location: params[:location],
          photo_type: params[:photo_type],
          photo_file: params[:photo],
          vk_image_src: params[:vk_image_src],
          user: current_user
        }
      end
    end
  end
end

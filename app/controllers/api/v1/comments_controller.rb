# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      def create
        @photo = Photo.find(params[:photo_id])
        outcome = Comments::Create.run(comments_params)
        return unless outcome.valid?

        render json: outcome.result, serializer: CommentSerializer
      end

      def index
        @photo = Photo.find(params[:photo_id])
        render json: @photo.comments, each_serializer: CommentSerializer
      end

      def comments_params
        {
          photo: @photo,
          user_id: current_user.id,
          content: params[:content],
          parent_id: params[:parent_id]
        }
      end
    end
  end
end

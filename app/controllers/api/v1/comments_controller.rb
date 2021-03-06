# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      def create
        @photo = Photo.find(params[:photo_id])

        @comment = @photo.comments.build
        @comment.user_id = current_user.id
        @comment.content = params[:content]
        parent_id = params[:parent_id]
        @comment.parent_id = parent_id
        return unless @comment.valid?

        @comment.save
        render json: @comment, serializer: CommentSerializer
      end

      def index
        @photo = Photo.find(params[:photo_id])
        render json: @photo.comments, each_serializer: CommentSerializer
      end
    end
  end
end

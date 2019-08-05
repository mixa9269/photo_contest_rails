class CommentsController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])

    @comment = @photo.comments.build
    @comment.user_id = current_user.id
    @comment.content = params[:content]
    parent_id = params[:parent]
    @comment.parent_id = parent_id
    if @comment.valid?
      @comment.save
      render json: @comment, serializer: CommentSerializer
    end
  end

  def list
    @photo = Photo.find(params[:photo_id])
    render json: @photo.comments, each_serializer: CommentSerializer
  end
end

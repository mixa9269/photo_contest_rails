class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    return if current_user.id == @photo.user_id

    @like = @photo.likes.build
    @like.user_id = current_user.id
    if @like.valid?
      @like.save
      @photo.reload
    end
  end

  def destroy
    like = Like.find(params[:id])
    @photo = Photo.find(like.photo_id)
    return unless current_user.id === like.user_id

    like.destroy
    @photo.reload
  end
end

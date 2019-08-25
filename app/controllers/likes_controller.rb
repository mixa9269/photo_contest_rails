# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    return if current_user.id == @photo.user_id

    outcome = Likes::Create.run(photo: @photo, user: current_user)
    return unless outcome.valid?
    @photo.reload
  end

  def destroy
    like = Like.find(params[:id])
    @photo = Photo.find(like.photo_id)
    return unless current_user.id == like.user_id

    like.destroy
    @photo.reload
  end
end

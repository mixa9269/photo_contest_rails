class PhotosController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @photo = current_user.photos.build if logged_in?
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = 'Photo uploaded!'
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

    def photo_params
      params.require(:photo).permit(:title, :photo, :location)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end

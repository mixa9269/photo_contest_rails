class PhotosController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @photo = current_user.photos.build if logged_in?
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Photo uploaded! It'll be in rating when it is approved"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @photo = Photo.find_by_id(params[:id])
  end

  def index
    @search = params[:search] || ''
    photos = Photo.search(@search)
    if params[:sort] == 'by_date'
      @by_date = true
      photos = photos.reorder(created_at: :desc)
    elsif params[:sort] == 'by_comments'
      @by_comments = true
      photos = photos.reorder(comments_count: :desc)
    else
      @by_rating = true
      photos = photos.reorder(likes_count: :desc)
    end
    @photos = photos.page(params[:page]).per(5)
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

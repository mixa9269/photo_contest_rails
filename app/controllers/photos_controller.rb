# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :logged_in_user, only: %i[new create destroy]
  before_action :correct_user,   only: :destroy

  def new
    @photo = current_user.photos.build if logged_in?
    vk_photos
  end

  def create
    outcome = Photos::Create.run(photo_params)
    if outcome.valid?
      @photo = outcome.result
      flash[:success] = "Photo uploaded! It'll be in rating when it is approved"
      redirect_to root_url
    else
      @photo = outcome
      vk_photos
      render 'new'
    end
  end

  def show
    @photo = Photo.find_by_id(params[:id])
  end

  def index
    @search = params[:search] || ''
    @sort = params[:sort] || 'likes_count'
    @photos = Photo.approved.search(@search).reorder("#{@sort} DESC").page(params[:page]).per(5)
  end

  def destroy
    @photo.destroy
    redirect_to user_path(current_user)
  end

  def vk_photos
    vk = VkontakteApi::Client.new(current_user.token)
    @photos_from_vk =
      vk.photos.get_all(owner_id: current_user.uid, count: 10).items
  end

  private

  def photo_params
    {
      title: params[:photo][:title],
      location: params[:photo][:location],
      photo_type: params[:photo_type],
      photo_file: params[:photo][:photo],
      vk_image_src: params[:vk_image_src],
      user: current_user
    }
  end

  def correct_user
    @photo = current_user.photos.find_by(id: params[:id])
    redirect_to root_url if @photo.nil?
  end
end

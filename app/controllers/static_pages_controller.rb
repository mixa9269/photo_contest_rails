class StaticPagesController < ApplicationController
  def home
    @is_main_page = true
    @top3 = Photo.approved.by_likes.limit(3)
  end

  def gallery
    if params[:sort] == 'by_date'
      @by_date = true
      photos = Photo.approved.reorder(created_at: :desc)
    else
      @by_date = false
      photos = Photo.approved.reorder(likes_count: :desc)
    end
    @photos = photos.page(params[:page]).per(5)
  end
end

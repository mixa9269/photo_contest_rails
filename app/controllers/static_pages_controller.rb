class StaticPagesController < ApplicationController
  def home
    @is_main_page = true
    @top3 = Photo.approved.by_likes.limit(3)
  end

  def gallery
    if params[:sort] == 'by_date'
      @by_date = true
      photos = Photo.reorder(created_at: :desc)
    elsif params[:sort] == 'by_comments'
      @by_comments = true
      photos = Photo.reorder(comments_count: :desc)
    else
      @by_rating = true
      photos = Photo.reorder(likes_count: :desc)
    end
    @photos = photos.page(params[:page]).per(5)
  end
end

class StaticPagesController < ApplicationController
  def home
    @is_main_page = true
    @top3 = Photo.approved.by_likes.limit(3)
  end

  def gallery
    @photos = Photo.approved.page(params[:page]).per(5)
  end
end

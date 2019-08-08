class StaticPagesController < ApplicationController
  def home
    @is_main_page = true
    @top3 = Photo.approved.by_likes.limit(3)
  end
end

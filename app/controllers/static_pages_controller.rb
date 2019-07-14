class StaticPagesController < ApplicationController
  def home
    @is_main_page = true
    @top3 = Photo.limit(3) #TODO order
  end
end

class StaticPagesController < ApplicationController
  def home
    @is_main_page = true
    @top3 = Photo.where(aasm_state: :approved).limit(3) #TODO order
  end

  def gallery
    @photos = Photo.all
  end
end

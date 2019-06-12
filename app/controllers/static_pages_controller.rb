class StaticPagesController < ApplicationController
  def home
    @is_main_page = true
  end
end

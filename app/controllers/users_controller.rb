# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @photos = @user.photos.approved if @user
    @own_profile = @user.id == current_user.id
  end

  def edit
    if current_user.id.to_s == params[:id]
      @user = User.find_by(id: params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    name = params[:user][:name]
    @user.name = name
    @user.first_name = name.split(' ')[0]
    if @user.save
      flash[:success] = 'Your profile updated'
      redirect_to root_url
    else
      render 'new'
    end
  end
end

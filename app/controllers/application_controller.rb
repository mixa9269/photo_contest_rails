class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    !current_user.nil?
  end

  private

    def logged_in_user
      unless logged_in?
        flash[:danger] = 'Please log in.'
        redirect_to root_url
      end
    end
end

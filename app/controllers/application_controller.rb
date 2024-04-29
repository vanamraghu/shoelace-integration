class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def user_signed_in?
    session[:user_id].present?
  end

  helper_method :user_signed_in?

  def profile_url(post)
    "https://i.pravatar.cc/300?img=#{post.user.id}"
  end

  helper_method :profile_url

end

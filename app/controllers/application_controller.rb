class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound => e
    logger.fatal "User not found, but session still has id: #{e.message}"
    redirect_to signout_path && return
  end

  def signed_in?
    !current_user.nil?
  end

  def authorize_user!
    @user = User.find(params[:id])
    return if current_user == @user
    flash[:danger] = 'Access denied.'
    redirect_to root_url
  end

  def authenticate_user!
    return if current_user
    flash[:danger] = 'You need to sign in for access to that page'
    redirect_to root_url
  end
end

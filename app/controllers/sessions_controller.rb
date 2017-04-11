class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def new
    redirect_to '/auth/github'
  end

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    return unless user.valid?
    reset_session
    session[:user_id] = user.id
    flash[:success] = 'Signed in!'
    redirect_to request.env['omniauth.origin']
  end

  def destroy
    reset_session
    flash[:success] = 'Signed out!'
    redirect_to root_url
  end

  def failure
    flash[:danger] = "Authentication error: #{params[:message].humanize}"
    redirect_to root_url
  end
end

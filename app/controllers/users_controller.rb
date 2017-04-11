class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:show]

  def show
    @user = current_user
  end
end

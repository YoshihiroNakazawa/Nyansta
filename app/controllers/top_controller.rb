class TopController < ApplicationController
  def index
    authenticate_user!
    @users = User.all
  end
end

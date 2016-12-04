class TopController < ApplicationController
  def index
    authenticate_user!
    @users = User.where("id <> ?", current_user.id)
  end
end

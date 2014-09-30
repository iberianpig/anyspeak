class RoomsController < ApplicationController

  def index
    if logged_in?
      @users = User.where.not(id: current_user.id)
    else
      @users = User.none
    end
  end

  def update_connect_uid
    if logged_in? && params[:connect_uid]
      current_user.update_attributes(connect_uid: params[:connect_uid])
    end
    render nothing: true
  end
end

# For main page controller
class RoomsController < ApplicationController
  # before_action :require_authentication, without: :index

  def index
    if logged_in?
      # @users = User.where.not(id: current_user.id)
      access_token = current_user.token
      @graph = Koala::Facebook::API.new(access_token)
      # profile = @graph.get_object('me')
      friends = @graph.get_connections('me', 'friends')
      @users = User.where(uid: friends.map{|friend| friend['id']})
    else
      @users = User.none
    end
  end

  def find_connect_uid
    if logged_in? && params[:user_id]
      user = User.find(params[:user_id])
      render json: {name:user.name ,connect_uid: user.connect_uid}, status: :ok
    else
      render json: { msg: 'please login' }, status: :ok
    end
  end

  def update_connect_uid
    if logged_in? && params[:connect_uid]
      current_user.update_attributes(
        connect_uid: params[:connect_uid],
        updated_at: Time.now)
    end
    render nothing: true
  end
end

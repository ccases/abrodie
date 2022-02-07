class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all
  end

  def show
    @users = User.where.not(id: current_user)
    @current_user = current_user
    # @rooms = current_user.rooms
    @rooms = Room.all
    @new_room = current_user.rooms.build

    users_arr = params[:name].split('_')
    if users_arr[0]=="drafts"
      @other_user = current_user
    elsif current_user.id.to_s != users_arr[-1]
      @other_user = User.find(users_arr[-1].to_i)
    elsif current_user.id.to_s != users_arr[-2]
      @other_user = User.find(users_arr[-2].to_i)
    else
      @other_user = nil
    end

    @room = Room.find_by(name: params[:name]) || current_user.rooms.create!(name: params[:name])
    @messages = @room.messages.where.not(body: nil)
    @message = @room.messages.build(user: current_user)
  end

  def new
    @new_room = current_user.rooms.build
  end

  def create
  #   debugger
  #   current_user.rooms.create(room_params)
  #   redirect_to messages_path(37)
  end

  def room_params
    params.require(:room).permit(:name)
  end
end

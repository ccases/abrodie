class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all
  end

  def show
    @users = User.where.not(id: current_user)

    # @rooms = current_user.rooms
    @rooms = Room.all
    @new_room = current_user.rooms.build
    @room = Room.find_by(name: params[:name]) || current_user.rooms.create!(name: params[:name])
    @messages = @room.messages.where.not(body: nil)
    @message = @room.messages.build(user: current_user)
  end

  def new
    @room = current_user.rooms.build
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

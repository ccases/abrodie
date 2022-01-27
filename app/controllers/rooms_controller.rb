class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all
  end

  def show
    @users = User.where.not(id: current_user)

    # @rooms = current_user.rooms
    @rooms = Room.all
    @room = current_user.rooms.build

    @chatroom = Room.find_by(name: @room_name) || current_user.rooms.create!(name: @room_name)
    @messages = @chatroom.messages.where.not(body: nil)
    @message = @chatroom.messages.build(user: current_user)
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    debugger

  #   debugger
  #   current_user.rooms.create(room_params)
  #   redirect_to messages_path(37)
  end

  def room_params
    params.require(:room).permit(:name)
  end
end

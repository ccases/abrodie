class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all
  end

  def create
    @room = Room.create(room_params)
  end

  def room_params
    params.require(:room).permit(:name)
  end
end

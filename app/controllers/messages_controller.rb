class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room_name, only: [:create, :show]
  # before_action :set_chatroom, only: [:create, :show]

  def index
    @rooms = current_user.rooms
  end

  def show
    @users = User.where.not(id: current_user)

    # @rooms = current_user.rooms
    @rooms = Room.all
    @room = Room.new
    @other_user = User.find(params[:id])

    @chatroom = Room.find_by(name: @room_name) || Room.create(name: @room_name)
    @messages = @chatroom.messages.where.not(body: nil)
    @message = @chatroom.messages.build(user: current_user)
  end

  def new
  end

  def create
    @message = @chatroom.messages.create!(body: msg_params[:body], user: current_user)
    # room = Room.find_by(name: @room_name)
    # @message = @chatroom.messages.create!(body: msg_params[:body], user: current_user)
    # debugger
    # if @message.save
    # else
    # end
  end

  private


  def set_room_name
    if params[:message] #meaning nagccreate
      @room_name = get_name(current_user.id, params[:message][:other_user_id])
    else
      @room_name = get_name(current_user.id, params[:id])
    end
  end

  def set_chatroom
    @chatroom = Room.find_by(name: @room_name) || Room.create(name: @room_name)
  end

  def get_name (user1id, user2id)
    a=user1id
    b=user2id.to_i
    if a < b
      "room_#{a}_#{b}"
    elsif a == b
      "drafts_#{a}"
    else
      "room_#{b}_#{a}"
    end
  end


  def msg_params
    params.require(:message).permit(:body)
  end
end

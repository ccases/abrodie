module RoomsHelper
  def get_room_name(user1, user2)
    a = user1.id
    b = user2.id
    if a < b
      "room_#{a}_#{b}"
    else
      "room_#{b}_#{a}"
    end
  end
end

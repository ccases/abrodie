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

  def get_user_name(user)
    if user&.applicant
      "#{user.applicant.fname} #{user.applicant.lname}"
    elsif user&.admin
      "#{user.admin.fname} #{user.admin.lname}"
    elsif user&.agency
      user.agency.name # CHANGE TO THIS PAG MAY VALIDATIONS NA @other_user&.name 
    else
      nil
    end
  end
end

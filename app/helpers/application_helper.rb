module ApplicationHelper
  def msg_time_formatter(time)
    if Time.now - time < 60*5
      time.strftime("%I:%M %p")
    end
  end

end

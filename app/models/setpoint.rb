class Setpoint < ActiveRecord::Base
  attr_accessible :room_id, :temperature, :times, :day

  belongs_to :room

  default_scope :order => "day ASC, DATE_FORMAT(times, '%H%m')"

  def day_full
    if self.day == 1 
      'Monday'
    elsif self.day == 2 
      'Tuesday'
    elsif self.day == 3 
      'Wednesday'  
    elsif self.day == 4
      'Thursday'  
    elsif self.day == 5 
      'Friday'  
    elsif self.day == 6 
      'Saturday'
    elsif self.day == 0   
      'Sunday' 
    end 
  end
end

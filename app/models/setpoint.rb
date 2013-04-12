class Setpoint < ActiveRecord::Base
  attr_accessible :room_id, :temperature, :times, :day
end

# -*- encoding : utf-8 -*-
class Setpoint < ActiveRecord::Base
  attr_accessible :room_id, :temperature, :times, :day, :room
  belongs_to :room
  default_scope :order => "day ASC, DATE_FORMAT(times, '%H%m')"

  validates :room, :times, :day, :temperature, :presence => true
  validates :temperature, :inclusion => 6..40

  def day_full
    if self.day == 1
      'Lundi'
    elsif self.day == 2
      'Mardi'
    elsif self.day == 3
      'Mercredi'
    elsif self.day == 4
      'Jeudi'
    elsif self.day == 5
      'Vendredi'
    elsif self.day == 6
      'Samedi'
    elsif self.day == 0
      'Dimanche'
    end
  end
end

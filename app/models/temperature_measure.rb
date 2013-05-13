# -*- encoding : utf-8 -*-
class TemperatureMeasure < ActiveRecord::Base
  attr_accessible :temperature, :room_id, :created_at, :updated_at

  belongs_to :room, inverse_of: :temperature_measures

  default_scope :order => "created_at DESC"

end

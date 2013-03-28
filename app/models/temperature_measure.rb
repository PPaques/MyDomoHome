class TemperatureMeasure < ActiveRecord::Base
  attr_accessible :temperature

  belongs_to :room, inverse_of: :temperature_measures

  default_scope :order => "created_at DESC"

end
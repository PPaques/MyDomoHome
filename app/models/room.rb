class Room < ActiveRecord::Base
  attr_accessible :heating, :light, :name, :home, :temperature

  belongs_to :home, inverse_of: :rooms
  has_and_belongs_to_many :openings
  has_many :temperature_measures, inverse_of: :room
  has_many :heating_logs, inverse_of: :room

  after_save :save_temperature_measure

  # delta is a configuration value to say what's the delta value to save in history
  DELTA = 0.5

  private

  def save_temperature_measure
    if temperature_measures.last.nil? or ( temperature_changed? and (self.temperature - temperature_measures.last.temperature) > DELTA)
      temperature_measures.create(temperature: self.temperature)
    end
  end

end

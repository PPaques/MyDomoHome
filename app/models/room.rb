class Room < ActiveRecord::Base
  attr_accessible :heating, :light, :name, :home, :temperature, :isoutside

  belongs_to :home, inverse_of: :rooms
  has_and_belongs_to_many :openings
  has_many :temperature_measures, inverse_of: :room
  has_many :heating_logs, inverse_of: :room

  after_save :save_temperature_measure
  after_save :save_heating_log

  # delta is a configuration value to say what's the delta value to save in history
  DELTA = 0.5

  def self.consigne
    20
  end

  def is_connected_outside(visited)
    # On parcours chaque ouverture de la pièce
    self.openings.each do |opening|
      # Si l'ouverture est ouverte
      if opening.opened? 
        # On parcours les pièces connectées
        opening.rooms.each do |room|
          # Si la pièce connectée est l'extérieur, on renvoie true
          if room.isoutside?
            puts " -> Exterieur !"
            return true
          # Sinon, si la pièce n'a pas encore été visitée, on vérifie si la pièce suivante est connectée à l'extérieur
          elsif !visited.include?(room)
            print " -> " + room.name
            if room.is_connected_outside(visited << room)
              return true
            end
          end
        end
      end
    end
    puts ""
    return false
  end

  private

  def save_temperature_measure
    if self.temperature.nil? 
      self.temperature = 0
    end
    if temperature_measures.last.nil? or ( temperature_changed? and (self.temperature - temperature_measures.last.temperature) > DELTA)
      temperature_measures.create(temperature: self.temperature)
    end
  end

  def save_heating_log
    if heating_logs.last.nil? or ( heating_changed? )
      heating_logs.create(heating: self.heating)
    end
  end


end

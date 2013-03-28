class Home < ActiveRecord::Base
  attr_accessible :mode_auto

  has_many :rooms, inverse_of: :home
  has_many :openings, through: :rooms

  require 'yaml'

  def update_opening_state
    if Rails.env.production?
      # Here goes the code for getting the data from all the GPIO 
    end

  end

  def update_temperature
    if Rails.env.production?
      # Here goes the code for getting the data from all the I2C
    end
  end

  # ROUTINE DE REGULATION
  def update_regulation
    # On passe en revue chaque pièce
    # Si la température est inférieure à la consigne, il faut (peut être) activer le chauffage
    # -> Si il existe un chemin jusqu'à l'extérieur, on stoppe le chauffage !
    # -> Si il existe des connexions entre les pièces et que une pièce doit être moins froide que la pièce, on stoppe le chauffage !
    # -> Sinon on chauffe
    consigne = 18
    self.rooms.each do |room|
      if room.temperature < (consigne - 0.5)
        puts "On chauffe : " + room.name + " " + room.temperature.to_s
      else
        # puts room.name + " :   à la température actuelle (" + room.temperature.to_s + "°c). On chauffe pas ! "
      end
    end
  end
end

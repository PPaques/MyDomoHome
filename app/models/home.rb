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
    puts ""
    consigne = 18.0
    consigne_hysteresis = 0.5
    # On passe en revue chaque pièce
    # Si la température est inférieure à la consigne, il faut (peut être) activer le chauffage
    # -> Si il existe un chemin jusqu'à l'extérieur, on stoppe le chauffage !
    # -> Si il existe des connexions entre les pièces et que une pièce doit être moins froide que la pièce, on stoppe le chauffage !
    # -> Sinon on chauffe
    
    # On parcours chaque pièce
    self.rooms.each do |room|

      # On compare la température de la pièce et la consigne
      if room.temperature < (consigne - consigne_hysteresis)
        # Si la température est trop basse, on vérifie d'abord si des fenêtres sont ouvertes
        room.openings.each do |opening|
          # Si l'ouverture est ouverte
          # if opening.opened? 
          # end

        end

        puts room.name + " : Consigne ("+consigne.to_s+") > temperature actuelle ("+room.temperature.to_s+") => on chauffe !"
      else
        puts room.name + " : Consigne ("+consigne.to_s+") < temperature actuelle ("+room.temperature.to_s+") => on chauffe pas "
      end
    end
    puts ""
  end
end

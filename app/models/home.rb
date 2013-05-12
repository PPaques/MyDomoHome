# -*- encoding : utf-8 -*-
class Home < ActiveRecord::Base
  attr_accessible :mode_auto, :rooms_attributes

  has_many :rooms, inverse_of: :home
  has_many :openings
  has_many :setpoints, through: :room

  accepts_nested_attributes_for :rooms

  def read_states
    if Rails.env.production?
      self.openings.each do |opening|
        opening.update_status
      end
      self.rooms.each do |room|
        room.read_all
      end
    end
  end

  def set_states
    if Rails.env.production?
      rooms.each do |room|
        room.set_all_states
      end
    end
  end

  # ROUTINE DE REGULATION
  def update_regulation
    if mode_auto
      consigne_hysteresis = 0.5
      # On passe en revue chaque pièce
      # Si la température est inférieure à la consigne, il faut (peut être) activer le chauffage
      # -> Si il existe un chemin jusqu'à l'extérieur, on stoppe le chauffage !
      # -> Si il existe des connexions entre les pièces et que une pièce doit être moins froide que la pièce, on stoppe le chauffage !
      # -> Sinon on chauffe

      # On parcours chaque pièce
      self.rooms.each do |room|
        # Si la pièce est l'extérieur, on passe à la suivante !
        if room.isoutside?
          next
        end

        #puts "\n" + room.name + " (" + room.temperature.to_s + " deg - Chauffage " + (room.heating == true ? "ON" : "OFF") + ")"
        # On compare la température de la pièce et la consigne
        if room.temperature < (room.consigne - consigne_hysteresis)
          #puts "    Lien vers l'exterieur ?"
          #print "        " + room.name
          if room.is_connected_outside([])
            room.update_attributes(heating: false)
            #puts "    => Ouverture vers l'exterieur : on ne chauffe pas"
          else
            # Si la température est trop basse, on vérifie d'abord si des fenêtres sont ouvertes
            room.update_attributes(heating: true)
            #puts "    => Consigne ("+room.consigne.to_s+") > temperature actuelle ("+room.temperature.to_s+") : on chauffe !"
          end
        else
          room.update_attributes(heating: false)
          #puts "    => Consigne ("+room.consigne.to_s+") < temperature actuelle ("+room.temperature.to_s+") : on ne chauffe pas"
        end
      end
      #puts ""
    end
  end
end

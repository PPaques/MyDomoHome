# -*- encoding : utf-8 -*-
class Home < ActiveRecord::Base
  attr_accessible :mode_auto, :rooms_attributes

  has_many :rooms, inverse_of: :home
  has_many :openings

  accepts_nested_attributes_for :rooms

  FACTOR_FOR_ADC =9.0909

  def update_opening_state
    if Rails.env.production?
      self.openings.each do |opening|
        opening.update_status
      end
    end
  end

  def update_heatings_state
    if Rails.env.production?
      rooms.each do |room|
        room.update_heating_state
      end
    end
  end

  def update_temperature
    if Rails.env.production? and false
      # need the card to test that ...
      # Here goes the code for getting the data from all the I2C
      @i2c_port = "/dev/i2c-1"
      @i2c_device = ::I2C.create("/dev/i2c-1")
      @converter_address = 48

      # Command system
      # SD | C2 | C1 | C0 | PD1 | PD0 | X X
      # SD : sigle ended (1)  or différential (0)
      # C2-C0 : Channel Selection
      # PD 1/0 : Power down selection
      #    PD1  PD0
      #     0    0  Power down between A/D conversion
      #     0    1  Internal reference OFF, A/D convert ON
      #     1    0  Internal reference ON , A/D convert OFF
      #     1    1  Internal reference ON , A/D convert ON (NORMAL MODE)

      # Putting ON the 4 A/D convert with internal reference ON (see asd7828 datasheet)
      @i2c_device.write(eval(@converter_address), 0b10001100) # channel 0 ON
      # now reading the value
      sleep 0.1
      temp_chan0 = @i2c_device.read(eval(@converter_address))
      temp_chan0 = temp_chan0 * FACTOR_FOR_ADC
      self.rooms.find('Extérieur').update_attributes(temperature: temp_chan0)

      @i2c_device.write(eval(@converter_address), 0b11001100) # channel 1 ON
      # now reading the value
      sleep 0.1
      temp_chan1 = @i2c_device.read(eval(@converter_address))
      temp_chan1 = temp_chan0 * FACTOR_FOR_ADC
      self.rooms.find('Salon').update_attributes(temperature: temp_chan1)


      @i2c_device.write(eval(@converter_address), 0b10011100) # channel 2 ON
      # now reading the value
      sleep 0.1
      temp_chan2 = @i2c_device.read(eval(@converter_address))
      temp_chan2 = temp_chan0 * FACTOR_FOR_ADC
      self.rooms.find('Chambre').update_attributes(temperature: temp_chan2)

      @i2c_device.write(eval(@converter_address), 0b11011100) # channel 3 ON
      # now reading the value
      sleep 0.1
      temp_chan3 = @i2c_device.read(eval(@converter_address))
      temp_chan3 = temp_chan0 * FACTOR_FOR_ADC
      self.rooms.find('Cuisine').update_attributes(temperature: temp_chan3)

      @i2c_device.write(eval(@converter_address), 0b10100000) # channel 4 OFF
      @i2c_device.write(eval(@converter_address), 0b11100000) # channel 5 OFF
      @i2c_device.write(eval(@converter_address), 0b10110000) # channel 6 OFF
      @i2c_device.write(eval(@converter_address), 0b11110000) # channel 7 OFF

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

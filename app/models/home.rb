# -*- encoding : utf-8 -*-
class Home < ActiveRecord::Base
  attr_accessible :mode_auto, :rooms_attributes

  has_many :rooms, inverse_of: :home
  has_many :openings
  has_many :setpoints, through: :room

  before_update :merge_setpoints

  accepts_nested_attributes_for :rooms
  accepts_nested_attributes_for :setpoints


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

  # Constant for pour ADC
  # Factor => 250/4095 = 0.061050061
  ADC_FACTOR    = 0.061050061
  ADC_ADRESS    = 0x48
  ADC_I2C_DEV   = "/dev/i2c-1"
  ADC_CHANNEL_0 = 0x8C
  ADC_CHANNEL_1 = 0xCC
  ADC_CHANNEL_2 = 0x9C
  ADC_CHANNEL_3 = 0xDC
  ADC_CHANNEL_4 = 0xAC
  ADC_CHANNEL_5 = 0xEC
  ADC_CHANNEL_6 = 0xBC
  ADC_CHANNEL_7 = 0xFC
  ADC_SIZE      = 0x02

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
    if Rails.env.production?

      @i2c_device = ::I2C.create(ADC_I2C_DEV)

      # Read Exterior temperature
      @i2c_device.write(ADC_ADRESS, ADC_CHANNEL_3)
      sleep 0.1
      temp = @i2c_device.read(ADC_ADRESS , ADC_SIZE).unpack("H*")[0].to_i(16) * ADC_FACTOR
      self.rooms.find('Extérieur').update_attributes(temperature: temp)

      # Read Salon Temperature
      @i2c_device.write(ADC_ADRESS, ADC_CHANNEL_4)
      sleep 0.1
      temp = @i2c_device.read(ADC_ADRESS , ADC_SIZE).unpack("H*")[0].to_i(16) * ADC_FACTOR
      self.rooms.find('Salon').update_attributes(temperature: temp)

      # Read Chambre Temperature
      @i2c_device.write(ADC_ADRESS, ADC_CHANNEL_5)
      sleep 0.1
      temp = @i2c_device.read(ADC_ADRESS , ADC_SIZE).unpack("H*")[0].to_i(16) * ADC_FACTOR
      self.rooms.find('Chambre').update_attributes(temperature: temp)

      # Read Cuisine Temperature
      @i2c_device.write(ADC_ADRESS, ADC_CHANNEL_6)
      sleep 0.1
      temp = @i2c_device.read(ADC_ADRESS , ADC_SIZE).unpack("H*")[0].to_i(16) * ADC_FACTOR
      self.rooms.find('Cuisine').update_attributes(temperature: temp)
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

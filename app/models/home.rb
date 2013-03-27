class Home < ActiveRecord::Base
  attr_accessible :mode_auto

  has_many :rooms, inverse_of: :home
  has_many :openings, through: :rooms

  require 'yaml'

  def update_opening_state
    if Rails.env.production?
      # Here goes the code for getting the data from all the GPIO 
    
    else
      # NO MORE USED

      # Here goes the code for getting the data from the yaml file in app/simulator/home.yml
      new_opening_state = YAML::load(File.read(Rails.root.join("app", "simulator","home.yml")))
      # lets make a while on the opening states
      new_opening_state['home']['opening_sates'].each do |new_opening|
  
        # lets take the opening
        opening = openings.find_by_name(new_opening[0])

        # saving status
        if new_opening[1] == "closed"
          opening.opened = false
        else 
          opening.opened = true
        end

        # saving in database if there is change
        opening.save! 
      end
    end

  end

  def update_temperature
    if Rails.env.production?
      # Here goes the code for getting the data from all the I2C
    
    else
      # Here goes the code for getting the data from the yaml file in app/simulator/home.yml
      new_opening_state = YAML::load(File.read(Rails.root.join("app", "simulator","home.yml")))
      # lets make a while on the opening states
      new_opening_state['home']['temperature'].each do |new_temperature|
  
        # lets take the room
        room = rooms.find_by_name(new_temperature[0])
        room.temperature = new_temperature[1].to_f
        # saving in database if there is change
        room.save! 
      end
    end
  end
end

# -*- encoding : utf-8 -*-
class Room < ActiveRecord::Base
  attr_accessible :heating, :light, :name, :home, :temperature, :isoutside, :gpio_heat_number, :temperature_slope, :color, :gpio_light_number, :temperature_channel, :light_channel, :light_measure

  belongs_to :home, inverse_of: :rooms
  has_many :setpoints, inverse_of: :room
  has_and_belongs_to_many :openings
  has_many :temperature_measures, inverse_of: :room
  has_many :heating_logs, inverse_of: :room

  before_save :update_slope
  before_save :update_light
  after_save :save_temperature_measure
  after_save :save_heating_log

  # delta is a configuration value to say what's the delta value to save in history
  DELTA = 0.5
  # Constant for pour ADC
  # Factor => 250/4095 = 0.061050061
  CONVERSION_FACTOR = 0.061050061
  LIGHT_FACTOR      = 0.024414063

  def consigne
    set = setpoints.unscoped.where("day=#{Time.now.wday} AND DATE_FORMAT(times, '%H%m') <= #{Time.now.hour}#{Time.now.min} AND room_id=#{self.id}").order("times DESC").first
    i=1
    while (set.nil? and i< 7)
      set=setpoints.unscoped.where("day=#{(Time.now.midnight-i.day).wday} AND room_id=#{self.id}").order("times ASC").first
      i+=1
    end

    if set.nil?
      20
    else
      set.temperature
    end
  end

  def self.isoutside?
    isoutside
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
            #puts " -> Exterieur !"
            return true
          # Sinon, si la pièce n'a pas encore été visitée, on vérifie si la pièce suivante est connectée à l'extérieur
          elsif !visited.include?(room)
            #print " -> " + room.name
            if room.is_connected_outside(visited << room)
              return true
            end
          end
        end
      end
    end
    #puts ""
    return false
  end

  def set_all_states
    self.set_heating_state
    self.set_light_state
  end

  def set_heating_state
    if Rails.env.production?
      gpio = Gpio.new(:pin => self.gpio_heat_number, :direction => :out)
      gpio.on  if self.heating
      gpio.off unless self.heating
    end
    return true
  end

  def set_light_state
    if Rails.env.production? and !self.light_channel.blank?
      gpio = Gpio.new(:pin => self.gpio_light_number, :direction => :out)
      gpio.on  if self.light
      gpio.off unless self.light
    end
  end

  def read_all_states
    self.read_light
    self.read_temperature
  end

  def read_light
    if Rails.env.production? and !self.temperature_channel.blank?
      self.light_measure = Adc.new(:channel => self.temperature_channel) * LIGHT_FACTOR
      self.save
    end
  end

  def read_temperature
    if Rails.env.production? and !self.temperature_channel.blank?
      self.temperature = Adc.new(:channel => self.temperature_channel) * CONVERSION_FACTOR
      self.save
    end
  end


  private

  def save_temperature_measure
    if self.temperature.nil?
      self.temperature = 0
    end
    if temperature_measures.last.nil? or ( temperature_changed? and (self.temperature - temperature_measures.last.temperature).abs > DELTA)
      temperature_measures.create(temperature: self.temperature)
    end

  end

  def update_slope
    ys = [] # Ordonnées : les températures
    xs = [] # Abscisses : les dates et heures

    temperature_measures.find(:all, :conditions => ["created_at > ?", 2.hours.ago]).each do |mesure|
      ys << mesure.temperature
      xs << mesure.created_at.to_time.to_i
    end

    ys << self.temperature
    xs << Time.now.to_i

    # ymean = ys.reduce(0) { |sum, x} x + sum }
    # ymean = Float(ymean) / Float(ys.length)
    y_mean = ys.sum / ys.size.to_f

    # xmean = xs.reduce(0) { |sum, x} x + sum }
    # xmean = Float(xmean) / Float(xs.length)
    x_mean = xs.sum / xs.size.to_f

    numerator = (0...xs.length).reduce(0) do |sum, i|
      sum + ((xs[i] - x_mean) * (ys[i] - y_mean))
    end

    denominator = xs.reduce(0) do |sum, x|
      sum + ((x - x_mean) ** 2)
    end

    slope = (numerator / denominator)
    min_slope = 0.00005
    if slope > min_slope
      self.temperature_slope = "asc"
    elsif slope <- min_slope
      self.temperature_slope = "desc"
    else
      self.temperature_slope = "equ"
    end
    # self.temperature_slope = numerator.round(1).to_s + "/" + denominator.round(1).to_s + "=" + slope.to_s
  end

  def save_heating_log
    if heating_logs.last.nil? or ( heating_changed? )
      heating_logs.create(heating: self.heating)
    end
  end

  def update_light
    if light_measure_changed?
      #if home.

      #end
    end
  end

end

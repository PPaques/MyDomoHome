# -*- encoding : utf-8 -*-
class Opening < ActiveRecord::Base
  attr_accessible :opened, :type, :name, :rooms, :home, :gpio_number, :home_id

  has_and_belongs_to_many :rooms
  has_many :opening_measures, inverse_of: :opening
  belongs_to :home

  after_save :save_opening_measure

  def read_status
    gpio = Gpio.new(:pin => self.gpio_number, :direction => :in)
    self.opened = gpio.read
    self.save
  end

  private

  def save_opening_measure
    if opened_changed?
      opening_measures.create(opened: self.opened)
    end
  end
end

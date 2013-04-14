class Opening < ActiveRecord::Base
  attr_accessible :opened, :type, :name, :rooms, :home, :gpio_number

  has_and_belongs_to_many :rooms
  has_many :opening_measures, inverse_of: :opening
  belongs_to :home

  after_save :save_opening_measure

  def after_initialize
    @my_cache = {}
    if Rails.env.production?
      @gpio = Gpio.new(:pin => :gpio_number, :direction => :in)
    end
  end

  def self.update_status
    opened = @gpio.read
    self.save
  end

  private

  def save_opening_measure
    if opened_changed?
      opening_measures.create(opened: self.opened)
    end
  end
end

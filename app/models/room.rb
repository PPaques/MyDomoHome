class Room < ActiveRecord::Base
  attr_accessible :heating, :light, :name, :home, :temperature

  belongs_to :home, inverse_of: :rooms
  has_and_belongs_to_many :openings
end

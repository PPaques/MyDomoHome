class Home < ActiveRecord::Base
  attr_accessible :mode_auto

  has_many :rooms, inverse_of: :room 
end

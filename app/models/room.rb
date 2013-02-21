class Room < ActiveRecord::Base
  attr_accessible :heating, :light, :name

  belongs_to :home, inverse_of: :rooms
end

class HeatingLog < ActiveRecord::Base
  attr_accessible :heating

  belongs_to :room, inverse_of: :heating_logs

end
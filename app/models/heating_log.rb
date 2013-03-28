class HeatingLog < ActiveRecord::Base
  attr_accessible :opened

  belongs_to :room, inverse_of: :heating_logs

end
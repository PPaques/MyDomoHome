# -*- encoding : utf-8 -*-
class HeatingLog < ActiveRecord::Base
  attr_accessible :heating

  belongs_to :room, inverse_of: :heating_logs

  default_scope :order => "created_at DESC"

end

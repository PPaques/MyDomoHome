class OpeningMeasure < ActiveRecord::Base
  attr_accessible :opened

  belongs_to :opening, inverse_of: :opening_measures

  default_scope :order => "created_at DESC"

end
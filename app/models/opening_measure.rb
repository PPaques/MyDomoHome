class OpeningMeasure < ActiveRecord::Base
  attr_accessible :opened 

  belongs_to :opening, inverse_of: :opening_measures

end
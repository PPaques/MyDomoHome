class Opening < ActiveRecord::Base
  attr_accessible :opened, :type, :name, :rooms

  has_and_belongs_to_many :rooms
end

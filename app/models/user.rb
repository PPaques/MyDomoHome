# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :role
end

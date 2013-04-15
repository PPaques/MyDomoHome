# -*- encoding : utf-8 -*-
class AccueilController < ApplicationController
  def index
    @home = Home.first(:include => :rooms)
    respond_to do |format|
      format.html
    end
  end
end 

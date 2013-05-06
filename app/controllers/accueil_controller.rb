# -*- encoding : utf-8 -*-
class AccueilController < ApplicationController
  def index
    @home = Home.first(:include => :rooms)
    @colors = ["#006CFF", "#EE3C19", "#C8F000", "#FF9900"]
    respond_to do |format|
      format.html
    end
  end
end 

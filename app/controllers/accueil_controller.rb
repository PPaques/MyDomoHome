class AccueilController < ApplicationController
  # GET /accueil
  def index
    @home = Home.first(:include => :rooms)
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end 
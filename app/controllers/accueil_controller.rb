class AccueilController < ApplicationController
  # GET /users
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end 
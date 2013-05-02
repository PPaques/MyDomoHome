# -*- encoding : utf-8 -*-
class SimulatorController < ApplicationController
  # GET /simulator
  def index
    @rooms = Home.first.rooms
    @openings = Home.first.openings

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def create
    params.each do |type,data|
      if type.match(/temperature_/)
        #logger.info type.gsub(/temperature_/,'')
        Room.find_by_id(type.gsub(/temperature_/,'')).update_attributes(temperature: data)
      end

      if type.match(/opening_/)
        #logger.info type.gsub(/opening_/,'')
        Opening.find_by_id(type.gsub(/opening_/,'')).update_attributes(opened: true) if data == "open"
        Opening.find_by_id(type.gsub(/opening_/,'')).update_attributes(opened: false) if data == "closed"
      end


    end

    # redirect_to simulator_index_path, :notice => "Sucessfully saved"
    redirect_to simulator_index_path, :notice => "Sauvegarde réussie"
  end
end

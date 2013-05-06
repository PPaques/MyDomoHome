# -*- encoding : utf-8 -*-
class HistoryController < ApplicationController

  def getRecentJSON

  # { label: "Chambre", color: "#FF9900", data: [ [t, 1], [t+100000, -14], [t+200000, 5] ] },
    if params[:time].to_i >= 0
      if params[:time].to_i == 0
        time = 100000
      else
        time = params[:time].to_i
      end
    else
      time = 24 * 7
    end
    if params[:room].to_i >= 1
      @rooms = Room.where(:id => params[:room].to_i)
    else
      @rooms = Room.all
    end
  	result = []
  	# render json: 24.hours.ago
  	@rooms.each do |room|
  		# mesures = room.temperature_measures.where(["created_at >= ?", 24.hours.ago], :limit => 10)
  		mesures = room.temperature_measures.find(:all, :conditions => ["created_at > ?", time.hours.ago])
  		data = []
      data << [Time.now.to_i*1000, room.temperature]
  		mesures.each do |mesure|
  			data << [mesure.created_at.to_time.to_i*1000, mesure.temperature ]
  		end

  		result << {:label => room.name, :color => room.color, :data => data}
  	end
    render json: result
  end

  def index
    @time = 24*7
    if params[:time].to_i >= 0
      @time = params[:time].to_i
    end
    @rooms = Room.all
  end
end

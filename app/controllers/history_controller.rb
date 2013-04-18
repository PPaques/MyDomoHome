# -*- encoding : utf-8 -*-
class HistoryController < ApplicationController

  def getRecentJSON

  # { label: "Chambre", color: "#FF9900", data: [ [t, 1], [t+100000, -14], [t+200000, 5] ] },
  # { label: "Cuisine", color: "#C8F000", data: [ [t, 13], [t+100000, 11], [t+200000, -7] ] },
  # { label: "Salle de bain", color: "#EE3C19", data: [ [t, 5], [t+100000, -2], [t+200000, 12] ] },
  # { label: "Extérieur", color: "#006CFF", data: [ [t, -2], [t+100000, 3], [t+200000, -2] ] }

  	@rooms = Room.all
  	result = []
  	colors = ["#006CFF", "#EE3C19", "#C8F000", "#FF9900"]
  	# render json: 24.hours.ago
  	@rooms.each do |room|
  		# mesures = room.temperature_measures.where(["created_at >= ?", 24.hours.ago], :limit => 10)
  		mesures = room.temperature_measures.find(:all, :conditions => ["created_at > ?", 24.hours.ago])
  		data = []
  		mesures.each do |mesure|
  			data << [mesure.created_at.to_time.to_i*1000, mesure.temperature ]
  		end
  		result << {:label => room.name, :color => colors.shift, :data => data}
  	end
    a = [1, 2, 3]
	h = {:label => a, :foo => "bar"}
    render json: result
  end

end

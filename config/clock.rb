# -*- encoding : utf-8 -*-
require 'clockwork'
# load the entire env
require './config/boot'
require './config/environment'

include Clockwork

handler do |job|
  puts "Running #{job}"
end

every(1.seconds, 'regulation_update') { Home.first.update_regulation}
# every(1.seconds, 'openings_state_update') { Home.first.update_opening_state}
# every(10.seconds, 'temperature_state_update') {Home.first.update_temperature}
#  every(5.seconds, 'update_heatings_state') {Home.first.update_heatings_state}

# -*- encoding : utf-8 -*-
require 'clockwork'
# load the entire env
require './config/boot'
require './config/environment'

include Clockwork

handler do |job|
  puts "Running #{job}"
end

every(2.seconds,  'regulation_update')  {Home.first.update_regulation}
every(2.seconds,  'read_all_states')    {Home.first.read_states}
every(5.seconds,  'set_states')         {Home.first.set_states}

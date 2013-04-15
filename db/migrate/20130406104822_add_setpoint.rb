# -*- encoding : utf-8 -*-
class AddSetpoint < ActiveRecord::Migration
  def change
  	# Ajout d'un champs pour stocker le nom de famille
    add_column    :setpoints, "day",  :integer
  end
end

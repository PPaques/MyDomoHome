class AddSetpoint < ActiveRecord::Migration
  def up
  	# Ajout d'un champs pour stocker le nom de famille
    add_column    :setpoints, "day",  :integer
  end

  def down
  end
end

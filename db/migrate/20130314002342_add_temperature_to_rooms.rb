# -*- encoding : utf-8 -*-
class AddTemperatureToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :temperature, :float
  end
end

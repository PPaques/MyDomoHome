# -*- encoding : utf-8 -*-
class AddGpioHeatNumberToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :gpio_heat_number, :integer
  end
end

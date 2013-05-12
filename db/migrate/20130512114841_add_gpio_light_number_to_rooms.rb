class AddGpioLightNumberToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :gpio_light_number, :string
  end
end

class AddTemperatureSlopeToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :temperature_slope, :string
  end
end

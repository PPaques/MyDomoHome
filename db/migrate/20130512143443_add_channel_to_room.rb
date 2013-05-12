class AddChannelToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :temperature_channel, :integer
    add_column :rooms, :light_channel, :integer
  end
end

# -*- encoding : utf-8 -*-
class AddHomeIdToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :home_id, :integer
  end
end

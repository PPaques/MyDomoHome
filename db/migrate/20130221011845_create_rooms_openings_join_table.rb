# -*- encoding : utf-8 -*-
class CreateRoomsOpeningsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :openings_rooms, :id => false do |t|
      t.integer :opening_id
      t.integer :room_id
    end
  end

  def self.down
    drop_table :openings_rooms
  end
end

# -*- encoding : utf-8 -*-
class CreateSetpoints < ActiveRecord::Migration
  def change
    create_table :setpoints do |t|
      t.integer :room_id
      t.float :temperature
      t.timestamp :times

      t.timestamps
    end
  end
end

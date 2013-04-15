# -*- encoding : utf-8 -*-
class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.boolean :heating
      t.boolean :light
      t.text :name

      t.timestamps
    end
  end
end

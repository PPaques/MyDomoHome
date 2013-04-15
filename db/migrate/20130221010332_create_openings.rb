# -*- encoding : utf-8 -*-
class CreateOpenings < ActiveRecord::Migration
  def change
    create_table :openings do |t|
      t.boolean :opened
      t.text :name
      t.timestamps
    end
  end
end

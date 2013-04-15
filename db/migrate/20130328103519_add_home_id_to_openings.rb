# -*- encoding : utf-8 -*-
class AddHomeIdToOpenings < ActiveRecord::Migration
  def change
    add_column :openings, :home_id, :integer
  end
end

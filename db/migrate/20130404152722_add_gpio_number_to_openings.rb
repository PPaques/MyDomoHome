# -*- encoding : utf-8 -*-
class AddGpioNumberToOpenings < ActiveRecord::Migration
  def change
    add_column :openings, :gpio_number, :integer
  end
end

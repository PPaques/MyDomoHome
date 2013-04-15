class AddGpioNumberToOpenings < ActiveRecord::Migration
  def change
    add_column :openings, :gpio_number, :integer
  end
end

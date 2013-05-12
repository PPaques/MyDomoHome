class AddLightMeasureToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :light_measure, :integer
  end
end

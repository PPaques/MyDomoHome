class AddHomeIdToOpenings < ActiveRecord::Migration
  def change
    add_column :openings, :home_id, :integer
  end
end

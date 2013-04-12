class Changeformatcolumn < ActiveRecord::Migration
	 def change
    change_column :setpoints, :times, :time
  end
 
end

class CreateHistory < ActiveRecord::Migration
  def change
  	create_table :history do |t|
		  t.integer :opening_id
		  t.integer :room_id
		  t.integer :home_id
		  t.float	:value

		  t.timestamps
		end
	end
end
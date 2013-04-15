class AddHeatingLog < ActiveRecord::Migration
	def change
		create_table :heating_logs do |t|
			t.integer :room_id
			t.boolean :heating

			t.timestamps
		end
	end
end

class AddHistoryTables < ActiveRecord::Migration
  def change
    create_table :temperature_measures do |t|
      t.integer :room_id
      t.float :temperature

      t.timestamps
    end

    create_table :opening_measures do |t|
      t.integer :opening_id
      t.boolean :opened

      t.timestamps
    end
  end
end

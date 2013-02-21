class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.boolean :mode_auto

      t.timestamps
    end
  end
end

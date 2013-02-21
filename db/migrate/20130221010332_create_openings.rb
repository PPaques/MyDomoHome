class CreateOpenings < ActiveRecord::Migration
  def change
    create_table :openings do |t|
      t.string :type
      t.boolean :opened

      t.timestamps
    end
  end
end

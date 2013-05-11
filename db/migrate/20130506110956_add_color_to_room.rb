class AddColorToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :color, :string
  end
end

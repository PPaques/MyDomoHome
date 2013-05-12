class AddLightThreesholdToHome < ActiveRecord::Migration
  def change
    add_column :homes, :light_threeshold, :string
  end
end

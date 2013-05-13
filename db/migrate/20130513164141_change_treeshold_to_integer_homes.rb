class ChangeTreesholdToIntegerHomes < ActiveRecord::Migration
  def change
    change_column :homes, :light_threeshold, :integer
  end
end

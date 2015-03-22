class AddPrecisionToFields < ActiveRecord::Migration
  def change
    change_column :current_conditions, :lat, :decimal, :precision => 15, :scale => 10
    change_column :current_conditions, :long, :decimal, :precision => 15, :scale => 10
    change_column :current_conditions, :humidity, :decimal, :precision => 15, :scale => 10
    change_column :current_conditions, :wind, :decimal, :precision => 15, :scale => 10
  end
end

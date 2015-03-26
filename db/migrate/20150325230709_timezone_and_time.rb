class TimezoneAndTime < ActiveRecord::Migration
  def change
    add_column :phrases, :time_period, :string, default: 'any'
    add_column :users, :time_zone, :string, default: 'Central Time (US & Canada)'
  end
end

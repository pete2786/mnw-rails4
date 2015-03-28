class AddRawForecastToCurrentConditions < ActiveRecord::Migration
  def change
    add_column :current_conditions, :raw_forecast, :text
    add_column :current_conditions, :forecast_pending, :boolean, default: true
  end
end

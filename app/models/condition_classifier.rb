require 'season'

class ConditionClassifier
  include Season

  attr_accessor :conditions
  delegate :code, :wind_speed, :temperature, :humidity, to: :conditions, allow_nil: true

  WINDY_MPH = 15
  HUMIDITY_PERCENTAGE = 80

  def initialize(conditions)
    self.conditions = conditions
  end

  def phrase_params
    {
      condition: condition,
      temperature: temperature_range,
      season: season,
      time_period: time_period
    }
  end

  def condition
    @condition ||= process_condition
  end

  def temperature_range
    @temperature_range ||= process_temperature
  end

  def windy
    @windy ||= wind_speed > WINDY_MPH ? 'Yes' : 'No'
  end

  def freezing
    @general_temperature ||= temperature > 32 ? 'above_freezing' : 'below_freezing'
  end

  def time_period
    hour = Time.now.hour
    case season
    when 'winter'
      hour.between?(8, 17) ? 'day' : 'night'
    when 'summer'
      hour.between?(6, 21) ? 'day' : 'night'
    else 
      hour.between?(7, 19) ? 'day' : 'night'
    end
  end

  # http://bugs.openweathermap.org/projects/api/wiki/Weather_Condition_Codes
  def process_condition
    return 'humid' if humidity > HUMIDITY_PERCENTAGE && !rainy? && temperature > 75
    # Extreme weather
    if ['901', '902', '903'].include?(code)
      'disaster'
    elsif code.eql?('905')
      'windy'
    elsif code.eql?('741')
      'fog'
    elsif code.starts_with?('61') || code.starts_with?('62')
      'sleet'
    elsif code.starts_with?('2')
      'thunder'
    elsif code.starts_with?('60')
      'snowy'
    elsif code.starts_with?('3')
      'drizzle'
    elsif code.starts_with?('5') || code.eql?('701')
      'rain'
    elsif code.eql?('905') || code.eql?('804')
      'overcast'
    elsif code.eql?('803')
      'cloudy'
    elsif code.eql?('800') || code.eql?('801') || code.eql?('802')
      'clear'
    else
      nil
    end
  end

  def rainy?
    code.starts_with?('5') || code.eql?('701')
  end

  def process_temperature
    if temperature > 100
      'super_hot'
    elsif temperature > 75
      'hot'
    elsif temperature > 60
      'warm'
    elsif temperature > 40
      'cool'
    elsif temperature > 32
      'cold'
    elsif temperature == 32
      'freezing'
    elsif temperature > 20
      'above_zero'
    elsif temperature > 0
      'very_cold'
    elsif temperature > -10
      'below_zero'
    else
      'way_below_zero'      
    end
  end
end

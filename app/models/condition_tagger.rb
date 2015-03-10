class ConditionTagger
  attr_accessor :conditions
  delegate :code, :wind, :temperature, :humidity, to: :conditions

  WINDY_MPH = 15
  HUMIDITY_PERCENTAGE = 75
  ConditionTags = Struct.new(:temperature, :conditions)

  def initialize(conditions)
    self.conditions = conditions
  end

  def tags
    return @tags if defined?(@tags)

    @tags = process_conditions + process_temperature
  end

  # http://bugs.openweathermap.org/projects/api/wiki/Weather_Condition_Codes
  def process_conditions
    conditions_array = []
    # Check for extreme weather
    if ['901', '902', '903'].include?(code)
      conditions_array << 'disaster'

    # Windy
    elsif code.eql?('905')
      conditions_array << 'windy'

    # Fog
    elsif code.eql?('741')
      conditions_array << 'fog'

    # Sleet / freezing rain / snow shower
    elsif code.starts_with?('61') || code.starts_with?('62')
      conditions_array << 'sleet'

    # Thunderstorm
    elsif code.starts_with?('2')
      conditions_array << 'thunder'

    # Snowing
    elsif code.starts_with?('60')
      conditions_array << 'snowy'

    # Drizzle
    elsif code.starts_with?('3')
      conditions_array << 'drizzle'

    elsif code.starts_with?('5') || code.eql?('701')
      conditions_array << 'rain'

    elsif code.eql?('905') || code.eql?('804')
      conditions_array << 'overcast'

    elsif code.eql?('802') || code.eql?('803')
      conditions_array << 'cloudy'

    elsif code.eql?('801') || code.eql?('802')
      conditions_array << 'partially_cloudy'

    elsif code.eql?('800') 
      conditions_array << 'clear'
    end

    if humidity > HUMIDITY_PERCENTAGE && !conditions_array.include?('rain') && temperature > 75
      conditions_array << 'humid'
    end

    if wind > WINDY_MPH
      conditions_array << 'windy'
    end

    conditions_array
  end

  def process_temperature
    conditions_array = []
    if temperature > 100
      conditions_array << 'super_hot'
    elsif temperature > 75
      conditions_array << 'hot'
    elsif temperature > 60
      conditions_array << 'warm'
    elsif temperature > 40
      conditions_array << 'cool'
    elsif temperature > 32
      conditions_array << 'cold'
    elsif temperature == 32
      conditions_array << 'freezing'
    elsif temperature > 20
      conditions_array << 'below_freezing'
    elsif temperature > 0
      conditions_array << 'very_cold'
      conditions_array << 'below_freezing'
    elsif temperature > -10
      conditions_array << 'below_zero'
      conditions_array << 'below_freezing'
    else
      conditions_array << 'way_below_zero'
      conditions_array << 'below_freezing'
    end

    conditions_array
  end
end

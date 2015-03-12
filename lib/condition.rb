require 'open_weather'

class Condition < SimpleDelegator
  class << self
    def location(location)
      if !location.to_s.index(/^\d{5}$/).nil?
        geocode_by_zip(location)
      else
        new(Hashie::Mash.new(OpenWeather::Current.city(location)))
      end
    end

    def geocode(lat, long)
      new(Hashie::Mash.new(OpenWeather::Current.geocode(lat, long)))
    end

    def geocode_by_zip(zip)
      zip = ZIP_CODE.find(location)
      self.geocode(zip["latitude"].to_f, zip["longitude"].to_f)
    end
  end

  def initialize(condition)
    super
  end

  def code
    weather.first.id.to_s
  end

  def humidity
    main.humidity
  end

  def wind_speed
    wind.speed
  end

  def long
    coord.lon
  end

  def lat
    coord.lat
  end

  def temp_farenheit
    @temp_farenheit ||= ((main.temp * (9.0/5))-459.67).to_i
  end
  alias_method :temperature, :temp_farenheit

end

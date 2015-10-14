require 'open_weather'

class Condition < SimpleDelegator
  class << self
    def location(location)
      if !location.to_s.index(/^\d{5}$/).nil?
        geocode_by_zip(location)
      else
        condition = try_with_timeout{ OpenWeather::Current.city(location, APPID: Rails.application.secrets.owm_appid) }
        condition ? new(Hashie::Mash.new(condition)) : nil
      end
    end

    def geocode(lat, long)
      condition = try_with_timeout{ OpenWeather::Current.geocode(lat, long, APPID: Rails.application.secrets.owm_appid) }
      condition ? new(Hashie::Mash.new(condition)) : nil
    end

    def geocode_by_zip(zip)
      zip = ZIP_CODE.find(zip)
      geocode(zip["latitude"].to_f, zip["longitude"].to_f)
    end

    def with(params)
      if !params[:lat].blank? && !params[:long].blank?
        geocode(params[:lat], params[:long])
      else
        input_location = params[:current_condition][:location].blank? ? "Ely,Mn" : params[:current_condition][:location]
        location(input_location)
      end
    end

    def try_with_timeout(&block)
      begin
        Timeout::timeout(10) { block.call }
      rescue Timeout::Error, JSON::ParserError
        nil
      end
    end
  end

  def initialize(condition)
    super
  end

  def icon
    weather.first.icon
  end

  def description
    weather.first.description
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

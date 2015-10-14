require 'condition'
require 'open_weather'

class CurrentCondition < ActiveRecord::Base
  include Combable
  
  attr_accessor :condition
  belongs_to :phrase
  belongs_to :user

  before_create :assign_phrase
  after_create :add_points

  delegate :name, :temp_farenheit, :icon, :description, :code, :humidity, :lat, :long, :wind, :to_hash,
            to: :condition, allow_nil: true, prefix: true
  delegate :user, :phrase, :image, to: :phrase, prefix: true
  delegate :temperature_range, :time_period, :phrase_params, to: :condition_classifier, allow_nil: true

  validates :location, :temperature, :icon, :description, :code, :humidity, presence: true

  scope :recent, ->{ order('id desc').limit(5) }
  scope :by_user, ->(u){ where(user: u) }
  scope :in_last, ->(t){ where("created_at > ? ", t.ago)}
  scope :at, ->(l){ where( lat: l.lat, long: l.long) }

  combable :location, :temperature_range, :description, :wind

  def self.with(params)
    cc = new( condition: Condition.with(params.with_indifferent_access) )
    cc.attributes = cc.condition_params unless cc.condition.nil? || cc.condition.cod == "404"
    cc.location = LocationDecorator.find_by_id(params[:location_id]).try(:value) unless params[:location_id].blank?
    cc
  end

  def condition_params
    {
      location: condition_name,
      temperature: condition_temp_farenheit,
      icon: condition_icon,
      description: condition_description,
      code: condition_code,
      humidity: condition_humidity,
      lat: condition_lat,
      long: condition_long,
      wind: condition_wind,
      raw_response: condition_to_hash.to_s
    }
  end

  def assign_phrase
    self.phrase = determine_phrase
  end

  def add_points
    user.add_points(1) if user
  end

  def determine_phrase
    return Phrase.complete.defaults.sample if condition == nil
    
    WeightedPhrasePicker.new( ConditionClassifier.new(condition) ).phrase
  end

  def fetch_forecast
    return unless forecast_pending

    update_attributes(raw_forecast: OpenWeather::ForecastDaily.geocode(lat, long, cnt: 6, APPID: Rails.application.secrets.owm_appid), forecast_pending: false)
  end

  def forecast
    @forecast ||= (raw_forecast ? Hashie::Mash.new(eval(raw_forecast)) : nil)
  end

  def condition_classifier
    @condition_classifier ||= ConditionClassifier.new(self)
  end
end

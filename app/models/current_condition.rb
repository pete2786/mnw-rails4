require 'condition'

class CurrentCondition < ActiveRecord::Base
  attr_accessor :condition
  belongs_to :phrase
  belongs_to :user

  before_create :assign_phrase

  delegate :name, :temp_farenheit, :icon, :description, :code, :humidity, :lat, :long, :wind, :to_hash,
            to: :condition, allow_nil: true, prefix: true

  delegate :user, :phrase, :image, to: :phrase, prefix: true
  validates :location, :temperature, :icon, :description, :code, :humidity, presence: true

  scope :recent, ->{ order('id desc').limit(5) }
  scope :by_user, ->(u){ where(user: u) }

  def self.with(params)
    cc = new( condition: Condition.with(params.with_indifferent_access) )
    cc.attributes = cc.condition_params
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

  def determine_phrase
    return Phrase.defaults.sample if condition == nil
    cc = ConditionClassifier.new(condition)

    return  Phrase.with_time_period(cc.time_period).with_season(cc.season).with_condition(cc.condition).with_temperature(cc.temperature_range).sample ||
            Phrase.with_time_period(cc.time_period).with_season(cc.season).with_condition(cc.condition).any_temperature.sample ||
            Phrase.with_time_period(cc.time_period).with_season(cc.season).any_condition.with_temperature(cc.temperature_range).sample || 
            Phrase.defaults.sample
  end

  def phrase_params
    ConditionClassifier.new(self).phrase_params
  end
end

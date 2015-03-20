require 'condition'

class CurrentCondition < ActiveRecord::Base
  attr_accessor :condition
  belongs_to :phrase
  belongs_to :user

  before_create :assign_phrase

  scope :recent, ->{ order('id desc').limit(5) }
  scope :by_user, ->(u){ where(user: u) }

  def self.with(params)
    new( condition_params(Condition.with(params.with_indifferent_access)) )
  end

  def self.condition_params(condition)
    {
      location: condition.name,
      temperature: condition.temp_farenheit,
      icon: condition.icon,
      description: condition.description,
      code: condition.code,
      humidity: condition.humidity,
      lat: condition.lat,
      long: condition.long,
      wind: condition.wind,
      raw_response: condition.to_hash.to_s,
      condition: condition    
    }
  end

  def assign_phrase
    self.phrase = determine_phrase
  end

  def determine_phrase
    return Phrase.defaults.sample if condition == {}
    cc = ConditionClassifier.new(condition)

    return  Phrase.with_season(cc.season).with_condition(cc.condition).with_temperature(cc.temperature_range).sample ||
            Phrase.with_season(cc.season).with_condition(cc.condition).any_temperature.sample ||
            Phrase.with_season(cc.season).any_condition.with_temperature(cc.temperature_range).sample || 
            Phrase.defaults.sample
  end

  def phrase_params
    ConditionClassifier.new(self).phrase_params
  end
end

require 'condition'

class CurrentCondition < ActiveRecord::Base
  attr_accessor :condition
  belongs_to :phrase

  before_create :assign_phrase

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
    cc = ConditionClassifier.new(condition)

    if Phrase.with_season(cc.season).with_condition(cc.condition).with_temperature(cc.temperature_range).exists?
      self.phrase = Phrase.with_season(cc.season).with_condition(cc.condition).with_temperature(cc.temperature_range).sample
    elsif Phrase.with_season(cc.season).with_condition(cc.condition).any_temperature.exists?
      self.phrase = Phrase.with_season(cc.season).with_condition(cc.condition).any_temperature.sample
    elsif Phrase.with_season(cc.season).any_condition.with_temperature(cc.temperature_range).exists?
      self.phrase = Phrase.with_season(cc.season).any_condition.with_temperature(cc.temperature_range).sample
    else
      self.phrase = nil
    end
  end
end

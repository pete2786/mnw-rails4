class WeightedPhrasePicker
  attr_accessor :condition_classifier
  MATCH_TYPES = [:all_match, :any_temp_match, :any_condition_match]
  MATCH_TYPE_WEIGHTS = { all_match: 60, any_temp_match: 20, any_condition_match: 20 }

  def initialize(condition_classifier)
    self.condition_classifier = condition_classifier
  end

  def phrase
    send(weighted_match_type).sample ||
    alternate_match ||
    defaults.sample
  end

  def alternate_match
    sample = nil
    remaining_match_types.each do |match_type|
      sample = send(match_type).sample
      break unless sample.nil?
    end

    sample
  end  

  def weighted_match_type
    @weighted_match_type ||= WeightedRandomizer.new(MATCH_TYPE_WEIGHTS).sample
  end

  def remaining_match_types
    MATCH_TYPES - [weighted_match_type]
  end

  def all_match
    Phrase.complete.
           with_time_period(condition_classifier.time_period).
           with_season(condition_classifier.season).
           with_condition(condition_classifier.condition).
           with_temperature(condition_classifier.temperature_range)
  end

  def any_temp_match
    Phrase.complete.
          with_time_period(condition_classifier.time_period).
          with_season(condition_classifier.season).
          with_condition(condition_classifier.condition).
          any_temperature
  end

  def any_condition_match
    Phrase.complete.
          with_time_period(condition_classifier.time_period).
          with_season(condition_classifier.season).
          any_condition.
          with_temperature(condition_classifier.temperature_range)
  end

  def defaults
    Phrase.complete.defaults
  end
end

class CurrentConditionDecorator < Draper::Decorator
  decorates_finders
  delegate_all

  def text
    "#{description.capitalize}...#{combed_phrase}"
  end

  def image
    phrase.image.url
  end

  def url
    Rails.application.routes.url_helpers.current_condition_url(id)
  end

  def combed_phrase
    MustacheComber.new(phrase_phrase, object).combed_string
  end
end

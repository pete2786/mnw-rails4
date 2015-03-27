class CurrentConditionDecorator < Draper::Decorator
  decorates_finders
  delegate_all

  def text
    "#{description.capitalize}...#{phrase_phrase}"
  end

  def image
    phrase.image.url
  end

  def url
    Rails.application.routes.url_helpers.current_condition_url(id)
  end
end

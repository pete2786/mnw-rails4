class LocationDecorator < Draper::Decorator
  delegate_all
  decorates_finders

  def value
    if country == 'US'
      "#{name}, #{state}"
    else
      "#{name}, #{country}"
    end
  end
end

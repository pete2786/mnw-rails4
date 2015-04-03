class HomeController < ApplicationController
  def index
    @new_current_condition = CurrentCondition.new

    if current_user && !current_user.saved_locations.blank?
      location = current_user.saved_locations.first
      @current_condition = CurrentConditionDecorator.new( existing_condition(location) || fetch_condition(location) )
    end
  end

  def existing_condition(location)
    CurrentCondition.by_user(current_user).in_last(30.minutes).at(location).last
  end

  def fetch_condition(location)
    current_condition = CurrentCondition.with(lat: location.lat, long: location.long)
    current_condition.user = current_user
    current_condition.save
  end
end

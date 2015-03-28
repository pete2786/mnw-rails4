require 'condition'

class CurrentConditionsController < ApplicationController
  before_filter :auth_required, only: [:save_location]
  def create
    @current_condition = CurrentCondition.with(params)
    @current_condition.user = current_user
    
    if @current_condition.save
      redirect_to current_condition_path(@current_condition)
    else
      redirect_to root_path, error: "Unable to get weather, please try again."
    end
  end

  def show
    @current_condition = CurrentConditionDecorator.find(params[:id])
  end

  def save_location
    cc = CurrentCondition.find(params[:current_condition_id])
    SavedLocation.create(saved_location_params(cc))
    render nothing: true
  end

  def saved_location_params(current_condition)
    {
      name: current_condition.location,
      lat: current_condition.lat,
      long: current_condition.long,
      user: current_user
    }
  end
  private :saved_location_params
end

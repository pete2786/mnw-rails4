require 'condition'
require 'ostruct'

class CurrentConditionsController < ApplicationController
  before_filter :auth_required, only: [:save_location]
  before_filter :limit_creates, only: [:create]

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
    @new_current_condition = CurrentCondition.new
    @current_condition = CurrentConditionDecorator.find(params[:id])
  end

  def save_location
    cc = CurrentCondition.find(params[:current_condition_id])
    SavedLocation.create(saved_location_params(cc))

    redirect_to current_condition_path(cc)
  end

  def limit_creates
    return unless current_user
    location = OpenStruct.new(lat: params[:lat], long: params[:long])
    cc = CurrentCondition.by_user(current_user).in_last(10.seconds).at(location).last
    redirect_to current_condition_path(cc) if cc
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

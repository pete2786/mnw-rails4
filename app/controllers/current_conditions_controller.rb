require 'condition'

class CurrentConditionsController < ApplicationController
  def create
    @current_condition = CurrentCondition.with(params)
    @current_condition.user = current_user
    
    if @current_condition.save
      redirect_to current_condition_path(@current_condition)
    else
      raise "we done goofed"
    end
  end

  def show
    @current_condition = CurrentConditionDecorator.find(params[:id])
  end
end

require 'condition'

class CurrentConditionsController < ApplicationController
  def create
    @current_condition = CurrentCondition.with(params)
    if @current_condition.save
      redirect_to current_condition_path(@current_condition)
    else
      raise "we done goofed"
    end
  end

  def show
    @current_condition = CurrentCondition.find(params[:id])
  end
end

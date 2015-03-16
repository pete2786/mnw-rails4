class HomeController < ApplicationController
  def index
    @current_condition = CurrentCondition.new
  end
end

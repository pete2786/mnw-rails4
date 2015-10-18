class SchadenfreudeController < ApplicationController

  def new
    @new_schadenfreude = Schadenfreude.new
  end

  def create
    @schadenfreude = Schadenfreude.new( my_current_condition: CurrentCondition.with(my_location_params), 
                                        their_current_condition: CurrentCondition.with(their_location_params) )
    @schadenfreude.user = current_user if current_user
    
    if @schadenfreude.save
      redirect_to schadenfreude_path(@schadenfreude)
    else
      redirect_to root_path, error: "Achtung. Das ist nach gut! Try again."
    end
  end

  def show
    @new_schadenfreude = Schadenfreude.new
    @schadenfreude = find_schadenfreude
  end

  def update
    @schadenfreude = find_schadenfreude
    if can? :update, @schadenfreude
      @schadenfreude.update_attributes(schadenfreude_params)
      redirect_to schadenfreude_path(@schadenfreude)
    else
      redirect_to new_schadenfreude_path
    end
  end

  def my_location_params
    params[:my_location].merge(current_condition: {location: params[:schadenfreude][:my_location][:location]})
  end 

  def their_location_params
    params[:their_location].merge(current_condition: {location: params[:schadenfreude][:their_location][:location]})
  end

  def find_schadenfreude
    SchadenfreudeDecorator.find(params[:id])
  end

  def schadenfreude_params
    params.require(:schadenfreude).permit(:comment)
  end
end

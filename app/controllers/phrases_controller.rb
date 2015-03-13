require 'condition'

class PhrasesController < ApplicationController
  load_and_authorize_resource

  def new
    if params[:location]
      condition_classifer = ConditionClassifier.new(Condition.location(params[:location]))
      @phrase.attributes = condition_classifer.phrase_params
    end
  end

  def create
    if @phrase.save
      redirect_to phrase_path(@phrase)
    else
      render :new
    end
  end

  def update
    if @phrase.update_attributes(phrase_params)
      redirect_to phrase_path(@phrase)
    else
      render :new
    end
  end

  def by_location
    @condition = Condition.location(params[:location])
    cc = ConditionClassifier.new(@condition)

    if Phrase.with_season(cc.season).with_condition(cc.condition).with_temperature(cc.temperature_range).exists?
      @phrase = Phrase.with_season(cc.season).with_condition(cc.condition).with_temperature(cc.temperature_range).sample
    elsif Phrase.with_season(cc.season).with_condition(cc.condition).any_temperature.exists?
      @phrase = Phrase.with_season(cc.season).with_condition(cc.condition).any_temperature.sample
    elsif Phrase.with_season(cc.season).any_condition.with_temperature(cc.temperature_range).exists?
      @phrase = Phrase.with_season(cc.season).any_condition.with_temperature(cc.temperature_range).sample
    else
      @phrase = nil#default
    end
      
  end

  def phrase_params
    params.require(:phrase).permit(:season, :phrase, :stock_image_id, :image, :remote_custom_image_url, :custom_image_cache,
                                   :condition, :temperature)
  end
end

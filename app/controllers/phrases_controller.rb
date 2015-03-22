class PhrasesController < ApplicationController
  before_filter :auth_required
  load_and_authorize_resource

  def index
    @phrases = current_user.phrases
  end

  def new
    @phrase.attributes = phrase_params if params[:phrase]
  end

  def create
    @phrase.user = current_user
    
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

  def destroy
    @phrase.destroy
    redirect_to phrases_path
  end

  def phrase_params
    params.require(:phrase).permit(:season, :phrase, :stock_image_id, :image, :remote_custom_image_url, :custom_image_cache,
                                   :condition, :temperature, :custom_image)
  end
end

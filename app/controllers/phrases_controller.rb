class PhrasesController < ApplicationController
  before_filter :auth_required, except: [:index, :show]
  load_and_authorize_resource except: [:my]

  def index
    @phrases = filtered_phrases.paginate(page: params[:page], per_page: 25)
  end

  def my
    @phrases = current_user.phrases
  end

  def new
    @phrase.attributes = phrase_params if params[:phrase]
  end

  def create
    @phrase.user = current_user
    
    if @phrase.save
      redirect_to edit_phrase_path(@phrase)
    else
      render :new
    end
  end

  def update
    if @phrase.update_attributes(phrase_params)
      redirect_to phrase_path(@phrase)
    else
      render :edit
    end
  end

  def destroy
    @phrase.destroy
    redirect_to phrases_path
  end

  def phrase_params
    params.require(:phrase).permit(:season, :phrase, :stock_image_id, :image, :remote_custom_image_url, :custom_image_cache,
                                   :condition, :temperature, :custom_image, :time_period)
  end

  def filtered_phrases
    case params[:sort]
    when 'recent'
      Phrase.complete.order('created_at desc')
    else
      Phrase.complete.top
    end
    
  end
  private :filtered_phrases
end

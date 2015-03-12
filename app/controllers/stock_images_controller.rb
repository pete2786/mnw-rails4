class StockImagesController < ApplicationController
  load_and_authorize_resource

  def create
    if @stock_image.save
      redirect_to stock_image_path(@stock_image)
    else
      render :new
    end
  end

  def stock_image_params
    params.require(:stock_image).permit(:image)
  end
  private :stock_image_params
end

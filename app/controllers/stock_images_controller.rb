class StockImagesController < ApplicationController
  def new
    @stock_image = StockImage.new
  end

  def create
    @stock_image = StockImage.create(stock_image_params)
  end

  def show
    @stock_image = StockImage.find(params[:id])
  end

  def stock_image_params
    params.require(:stock_image).permit(:image)
  end
  private :stock_image_params
end

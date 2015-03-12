class StockImage < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end

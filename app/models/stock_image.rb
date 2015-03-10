class StockImage < ActiveRecord::Base
  acts_as_taggable
  mount_uploader :image, ImageUploader
end

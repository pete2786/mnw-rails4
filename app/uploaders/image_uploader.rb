class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  storage :aws
  process resize_to_fit: [800, 800]

  version :thumb do
    process resize_to_fill: [50,50]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url  
    "fallback/default.png"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end

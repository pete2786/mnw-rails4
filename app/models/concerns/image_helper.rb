module ImageHelper
  extend ActiveSupport::Concern

  def image
    return unless status == 'complete'
    has_stock_image? ? stock_image.image : custom_image
  end

  def thumb
    return unless status == 'complete'
    has_stock_image? ? stock_image.image.thumb : custom_image.thumb
  end

  def has_stock_image?
    image_type == :stock
  end

  def has_custom_image?
    image_type == :custom
  end

  def image_type
    (status == 'image' || !stock_image_id.blank?) ? :stock : :custom
  end

  def swap_image
    if stock_image_id_changed?
      self.remove_custom_image!
    elsif !custom_image.blank?
      self.stock_image_id = nil
    end
  end

  def no_image?
    stock_image_id.blank? && !custom_image? && remote_custom_image_url.blank?
  end

  def double_image?
    !stock_image_id.blank? && (custom_image? || !remote_custom_image_url.blank?)
  end

  def image_required  
    errors[:image] << "You must choose a stock image or upload a custom image" if no_image? || double_image?
  end
end

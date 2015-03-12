class Phrase < ActiveRecord::Base
  SEASONS = %w{any winter spring summer fall}
  CONDITIONS = %w{any clear cloudy disaster drizzle fog overcast partially_cloudy rain sleet snowy thunder}
  ABOVE_TEMP = %w{super_hot hot warm cool cold freezing}
  BELOW_TEMP = %w{very_cold below_zero way_below_zero}
  TEMPERATURES = %w{any above_freezing below_freezing} + ABOVE_TEMP + BELOW_TEMP

  has_many :phrase_votes
  belongs_to :stock_image

  mount_uploader :custom_image, ImageUploader

  scope :with_season, ->(s){where("season = ? or season = 'any'", s)}
  scope :with_temperature, ->(t){where("temperature = ? or temperature = ?", t, generic_temp(t))}
  scope :with_condition, ->(c){where(condition: c)}
  scope :any_temperature, ->{where(temperature: 'any')}
  scope :any_condition, ->{where(condition: 'any')}

  validates :phrase, presence: true, length: { maximum: 250 }
  validates :condition, presence: true, inclusion: CONDITIONS
  validates :temperature, presence: true, inclusion: TEMPERATURES
  validates :season, presence: true, inclusion: SEASONS
  validate :image_required

  def self.seasons
    SEASONS.map{|s| [s.titleize, s]}
  end

  def self.generic_temp(temp)
    ABOVE_TEMP.include?(temp) ? 'above_freezing' : 'below_freezing'
  end

  def self.conditions
    CONDITIONS.map{|s| [s.titleize, s]}
  end

  def self.temperatures
    TEMPERATURES.map{|s| [s.titleize, s]}
  end

  def image
    has_stock_image? ? stock_image.image : custom_image
  end

  def thumb
    has_stock_image? ? stock_image.image.thumb : custom_image.thumb
  end

  def has_stock_image?
    image_type == :stock
  end

  def has_custom_image?
    image_type == :custom
  end

  def image_type
    (new_record? || !stock_image_id.blank?) ? :stock : :custom
  end

  def no_image?
    stock_image_id.blank? && !custom_image?
  end

  def double_image?
    !stock_image_id.blank? && custom_image?
  end

  def image_required  
    errors[:image] << "You must choose a stock image or upload a custom image" if no_image? || double_image?
  end

end

class Phrase < ActiveRecord::Base
  SEASONS = %w{any winter spring summer fall}
  CONDITIONS = %w{any clear cloudy disaster drizzle fog overcast partially_cloudy rain sleet snowy thunder humid windy}
  ABOVE_TEMP = %w{super_hot hot warm cool cold freezing}
  BELOW_TEMP = %w{very_cold below_zero way_below_zero}
  TEMPERATURES = %w{any above_freezing below_freezing} + ABOVE_TEMP + BELOW_TEMP

  has_many :phrase_votes
  belongs_to :stock_image
  belongs_to :user

  mount_uploader :custom_image, ImageUploader

  scope :with_season, ->(s){where("season = ? or season = 'any'", s)}
  scope :with_temperature, ->(t){where("temperature = ? or temperature = ?", t, generic_temp(t))}
  scope :with_condition, ->(c){where(condition: c)}
  scope :any_temperature, ->{where(temperature: 'any')}
  scope :any_condition, ->{where(condition: 'any')}
  scope :defaults, ->{ any_temperature.any_condition.with_season('any') }

  before_validation :swap_image, except: :create

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

  def voted_on?(user)
    voted_up? || voted_down?
  end

  def voted_up?(user)
    phrase_votes.by_user(user).up.exists?
  end

  def voted_down?(user)
    phrase_votes.by_user(user).down.exists?
  end

  def vote_by(user)
    phrase_votes.by_user(user).first
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

  def swap_image
    if stock_image_id_changed?
      self.remove_custom_image!
    elsif custom_image_changed?
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

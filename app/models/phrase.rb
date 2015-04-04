class Phrase < ActiveRecord::Base
  include ImageHelper

  SEASONS = %w{any winter spring summer fall}
  CONDITIONS = %w{any clear cloudy disaster drizzle fog overcast partially_cloudy rain sleet snowy thunder humid windy}
  ABOVE_TEMP = %w{super_hot hot warm cool cold freezing}
  BELOW_TEMP = %w{very_cold below_zero way_below_zero}
  TEMPERATURES = %w{any above_freezing below_freezing} + ABOVE_TEMP + BELOW_TEMP
  TIME_PERIODS = %w{any day night}

  has_many :phrase_votes
  belongs_to :stock_image
  belongs_to :user

  delegate :name, to: :user, prefix: true, allow_nil: true

  mount_uploader :custom_image, ImageUploader

  scope :with_season, ->(s) {where("season = ? or season = 'any'", s)}
  scope :with_temperature, ->(t) {where("temperature = ? or temperature = ?", t, generic_temp(t))}
  scope :with_condition, ->(c) {where(condition: c)}
  scope :with_time_period, ->(t) {where("time_period = ? or time_period = 'any'", t)}
  scope :any_temperature, ->{where(temperature: 'any')}
  scope :any_condition, ->{where(condition: 'any')}
  scope :defaults, ->{ any_temperature.any_condition.with_season('any') }
  scope :complete, ->{ where(status: 'complete') }
  scope :top, ->(){  joins("LEFT JOIN phrase_votes up ON up.phrase_id = phrases.id and up.vote_type = 'Up'")
                      .joins("LEFT JOIN phrase_votes down ON down.phrase_id = phrases.id  and down.vote_type = 'Down'")
                      .group('phrases.id').order('COUNT(up.id) - COUNT(down.id) DESC')
                    }

  before_validation :swap_image, except: :create
  after_create :set_status_image
  after_save :set_status_complete, if: "!no_image?"

  validates :phrase, presence: true, length: { maximum: 250 }
  validates :condition, presence: true, inclusion: CONDITIONS
  validates :temperature, presence: true, inclusion: TEMPERATURES
  validates :season, presence: true, inclusion: SEASONS
  validates :time_period, presence: true, inclusion: TIME_PERIODS
  validate :image_required, if: :image_required?

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

  def self.time_periods
    TIME_PERIODS.map{|s| [s.titleize, s]}
  end
  
  def phrase_vote_rep
    phrase_votes.up.count - phrase_votes.down.count
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

  def image_required?
    status != 'phrase'
  end

  def set_status_image
    self.update_column(:status, 'image')
  end

  def set_status_complete
    self.update_column(:status, 'complete')
  end

end

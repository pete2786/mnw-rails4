class User < ActiveRecord::Base
  has_many :phrases
  has_many :current_conditions
  has_many :phrase_votes, through: :phrases
  has_many :saved_locations
  has_merit

  scope :top, ->(n){ joins('LEFT JOIN merit_scores ON merit_scores.sash_id = users.sash_id ' \
                      'LEFT JOIN merit_score_points ON merit_score_points.score_id = merit_scores.id')
                      .group('users.id', 'merit_scores.sash_id').order('SUM(num_points) DESC')
                      .limit(n)
                    }

  scope :top_contributers, ->(n){ joins('LEFT JOIN phrases ON phrases.user_id = users.id ')
                      .group('users.id').order('count(*) DESC')
                      .limit(n)
                    }

  after_update :process_badges
  after_create :send_welcome_email

  def process_badges
    self.add_badge(1) unless self.has_badge?(1) && self.id <= 100
  end

  def phrase_vote_rep
    phrase_votes.up.count - phrase_votes.down.count
  end

  def phrase_rep_name
    ((badge_names & ['rookie', 'pro', 'minnesotan']).first || 'N/A').capitalize
  end

  def badge_names
    @badge_names ||= badges.map(&:name)
  end

  def has_badge?(badge_id)
    !find_badge(badge_id).nil?
  end

  def find_badge(badge_id)
    badges.select{|b| b.id == badge_id}.first
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  def saved?(current_condition)
    saved_locations.loc_name(current_condition.location).exists? || 
    saved_locations.geo(current_condition.lat, current_condition.long).exists?
  end
end

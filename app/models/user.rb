class User < ActiveRecord::Base
  has_many :phrases
  has_many :current_conditions
  has_many :phrase_votes, through: :phrases
  has_merit

  scope :top, ->(n){ joins('LEFT JOIN merit_scores ON merit_scores.sash_id = "users".sash_id ' \
                      'LEFT JOIN merit_score_points ON merit_score_points.score_id = merit_scores.id')
                      .group('"users".id', '"merit_scores".sash_id').order('SUM(num_points) DESC')
                      .limit(n)
                    }

  after_update :process_badges

  def process_badges
    self.add_badge(1) unless Merit::Badge.find(1).users.include?(self) && self.id <= 100
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
end

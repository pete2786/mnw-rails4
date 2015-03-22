class User < ActiveRecord::Base
  has_merit

  has_many :phrases
  has_many :current_conditions
  has_many :phrase_votes, through: :phrases

  after_update :process_badges

  def process_badges
    self.add_badge(1) unless Merit::Badge.find(1).users.include?(self) && self.id <= 100
  end

  def phrase_vote_rep
    phrase_votes.up.count - phrase_votes.down.count
  end
end

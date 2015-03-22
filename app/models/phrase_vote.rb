class PhraseVote < ActiveRecord::Base
  belongs_to :phrase
  belongs_to :user
  delegate :user, to: :phrase, prefix: true

  scope :up, ->{ where(vote_type: 'Up') }
  scope :down, ->{ where(vote_type: 'Down') }
  scope :by_user, ->(u){ where(user: u) }

  validates :phrase, uniqueness: {scope: :user}
end

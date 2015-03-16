class PhraseVote < ActiveRecord::Base
  belongs_to :phrase
  belongs_to :user

  scope :positive, ->(){type: 'Positive'}
  scope :negative, ->(){type: 'Negative'}

  validates :phrase, uniqueness: {scope: :user}
end

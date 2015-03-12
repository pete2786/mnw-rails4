class PhraseVote < ActiveRecord::Base
  belongs_to :phrase
  belongs_to :user
end

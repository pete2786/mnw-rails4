class PhaseVote < ActiveRecord::Base
  belongs_to :phrase
  belongs_to :user
end

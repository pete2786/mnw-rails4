class AddTypeToPhraseVote < ActiveRecord::Migration
  def change
    add_column :phrase_votes, :vote_type, :string
  end
end

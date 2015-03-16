class PhraseVotesController < ApplicationController
  def create
    phrase = Phrase.find(params[:phrase_id])

    if phrase.phrase_votes.by_user(current_user).exists?
      phrase.phrase_votes.by_user(current_user).update_attributes(phrase_vote_params)
    else
      phrase.phrase_votes.create(phrase_vote_params)
    end
  end

  def destroy
    phrase = Phrase.find(params[:phrase_id])
    vote = phrase.phrase_votes.find(params[:id])

    vote.destroy
  end

  def phrase_vote_params
    params.require(:phrase_vote).allow(:type)
  end
end

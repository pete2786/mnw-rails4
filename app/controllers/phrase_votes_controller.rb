class PhraseVotesController < ApplicationController
  def create
    @phrase = Phrase.find(params[:phrase_id])

    if @phrase.phrase_votes.by_user(current_user).exists?
      @phrase.phrase_votes.by_user(current_user).first.update_attributes(phrase_vote_params)
    else
      phrase_vote = @phrase.phrase_votes.new(phrase_vote_params)
      phrase_vote.user = current_user
      phrase_vote.save
    end
  end

  def destroy
    @phrase = Phrase.find(params[:phrase_id])
    vote = @phrase.phrase_votes.find(params[:id])

    vote.destroy
  end

  def phrase_vote_params
    params.permit(:vote_type)
  end
end

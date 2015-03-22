class PhraseVotesController < ApplicationController
  before_filter :auth_required
  
  def create
    authorize! :create, PhraseVote
    @phrase = Phrase.find(params[:phrase_id])

    if @phrase.vote_by(current_user)
      @phrase.vote_by(current_user).update_attributes(phrase_vote_params)
    else
      phrase_vote = @phrase.phrase_votes.new(phrase_vote_params)
      phrase_vote.user = current_user
      phrase_vote.save
    end
  end

  def destroy
    @phrase = Phrase.find(params[:phrase_id])
    vote = @phrase.phrase_votes.find(params[:id])
    authorize! :destroy, vote

    vote.destroy
  end

  def phrase_vote_params
    params.permit(:vote_type)
  end
end

class PhraseVotesController < ApplicationController
  before_filter :auth_required
  
  def create
    authorize! :create, PhraseVote
    @phrase = Phrase.find(params[:phrase_id])
    @phrase_vote = @phrase.vote_by(current_user) || @phrase.phrase_votes.new(phrase_vote_params)

    if @phrase_vote.new_record?
      @phrase_vote.user = current_user
      @phrase_vote.save
    else
      @phrase.vote_by(current_user).update_attributes(phrase_vote_params)
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

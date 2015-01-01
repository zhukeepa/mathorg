class VotablesController < ApplicationController
  def upvote
    vote('good', params)
  end

  def downvote
    vote('bad', params)
  end

  def rate
    v = get_votable_from_id_and_class(params[:votable_id], params[:votable_type])
    v.vote_by voter: current_user, vote_scope: params[:scope], vote_weight: params[:rating]

    render 'votables/rating', locals: { lower: params[:lower], upper: params[:upper], votable: v, scope: params[:scope], disp_text: params[:disp_text] }
  end

  def vote(pos, params)
    v = get_votable_from_id_and_class(params[:votable_id], params[:votable_type])
    v.vote_by voter: current_user, vote_scope: params[:scope], vote: pos

    render 'votables/vote', locals: { votable: v, scope: params[:scope], disp_text: params[:disp_text] }
  end

  def get_votable_from_id_and_class(id, type)
    ## ::TODO:: some safety shit to make sure class is real and shit
    type.constantize.find(id)
  end
end
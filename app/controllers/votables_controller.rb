class VotablesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  
  def upvote
    vote('good', params)
  end

  def downvote
    vote('bad', params)
  end

  def rate
    v = get_votable_from_id_and_class(params[:votable_id], params[:votable_type])
    v.vote_by voter: current_user, vote_scope: params[:scope], vote_weight: params[:rating]

    if !v.vote_registered? # if did nothing, vote was already there, in which case unvote
      v.unvote_by current_user, vote_scope: params[:scope], vote_weight: params[:rating]
    end

    render 'votables/rating', locals: { lower: params[:lower], upper: params[:upper], votable: v, scope: params[:scope], disp_text: params[:disp_text], show_average: params[:show_average] }
  end

  def vote(pos, params)
    v = get_votable_from_id_and_class(params[:votable_id], params[:votable_type])
    v.vote_by voter: current_user, vote_scope: params[:scope], vote: pos

    if !v.vote_registered? # if did nothing, vote was already there, in which case unvote
      v.unliked_by current_user, vote_scope: params[:scope], vote: pos
    end

    render 'votables/vote', locals: { votable: v, scope: params[:scope], disp_text: params[:disp_text] }
  end

  def get_votable_from_id_and_class(id, type)
    ## ::TODO_LATER:: implement safety check
    type.constantize.find(id)
  end
end
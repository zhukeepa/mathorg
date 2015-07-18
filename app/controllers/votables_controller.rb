class VotablesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  
  def upvote
    vote('good', params)

    # ::TODO_LATER:: refactor ?? 
    v = get_votable_from_id_and_class(params[:votable_id], params[:votable_type])
    if v.kind_of?(Solution) && v.author != current_user
      v.author.notify!(:solution_upvote, current_user, v)
    end
  end

  def downvote
    vote('bad', params)
  end

  def rate
    v = get_votable_from_id_and_class(params[:votable_id], params[:votable_type])
    v.vote_by voter: current_user, vote_scope: params[:scope], vote_weight: params[:rating]

    render 'votables/rating', locals: { lower: params[:lower], upper: params[:upper], votable: v, scope: params[:scope], disp_text: params[:disp_text], show_average: params[:show_average] }
  end

  def vote(pos, params)
    v = get_votable_from_id_and_class(params[:votable_id], params[:votable_type])
    v.vote_by voter: current_user, vote_scope: params[:scope], vote: pos

    render 'votables/vote', locals: { votable: v, scope: params[:scope], disp_text: params[:disp_text] }
  end

  def get_votable_from_id_and_class(id, type)
    ## ::TODO_LATER:: implement safety check
    type.constantize.find(id)
  end
end
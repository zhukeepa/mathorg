class SearchController < ApplicationController
  def results
  	@search_type = params[:search][:search_type]
    send("#{@search_type}_search_results", params[:search])
  end

  def index

  end

private 
  def problem_search_results(params)
    # pre-search: restrict problem id's before using Searchkick
    id_restrictions = Problem.all.map(&:id)

    # topics
    topics = Topic.where(name: params[:topics].split(',').map(&:strip))
    topics.each { |t| id_restrictions &= t.problems_and_solutions_ids }

    #flags
    id_restrictions &= current_user.problems_marked_as_working_on.map(&:id) if params[:currently_working_on] == "1"
    id_restrictions &= current_user.problems_marked_as_solved.map(&:id)     if params[:solved_by_me] == "1"
    id_restrictions &= current_user.problems_marked_as_favorited.map(&:id)  if params[:favorited_by_me] == "1"

    #source
    id_restrictions &= Problem.search(params[:source], fields: [:source]).map(&:id) if params[:source] != ""
    
    # now build up query
    where_params = {}
    where_params[:or] = []
    where_params[:id] = id_restrictions

    #difficulty
    min_diff, max_diff = params[:min_difficulty].to_i, params[:max_difficulty].to_i
    difficulty_query = [{difficulty: {gte: min_diff, lte: max_diff}}]
    difficulty_query << {difficulty: -1} if params[:include_unrated_difficulties] == "1"
    where_params[:or] << difficulty_query

    #difficulty
    min_elegance, max_elegance = params[:min_elegance].to_i, params[:max_elegance].to_i
    elegance_query = [{elegance: {gte: min_elegance, lte: max_elegance}}]
    elegance_query << {elegance: 100} if params[:include_unrated_elegances] == "1"
    where_params[:or] << elegance_query

    query = !params[:keywords].empty? ? params[:keywords] : "*"
    results = Problem.search query, fields: [:body], where: where_params, limit: 25

    @results = []
    results.each do |r| 
      @results << r 
    end
  end

  def explanation_search_results(params)
    # pre-search: restrict problem id's before using Searchkick
    id_restrictions = Explanation.all.map(&:id)

    # title
    id_restrictions &= Explanation.search(params[:title], fields: [:title]).map(&:id) if params[:title] != ""
    
    # authors
    id_restrictions &= Explanation.search(params[:authors], fields: [:authors]).map(&:id) if params[:authors] != ""

    # topics
    topics = Topic.where(name: params[:topics].split(',').map(&:strip))
    topics.each { |t| id_restrictions &= t.explanations.map(&:id) }

    query = !params[:keywords].empty? ? params[:keywords] : "*"
    results = Explanation.search query, fields: [:keywords], where: { id: id_restrictions }, limit: 25

    @results = []
    results.each do |r| 
      @results << r 
    end

  end
end

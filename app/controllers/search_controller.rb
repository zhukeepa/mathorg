class SearchController < ApplicationController
  def results
  	@search_type = params[:search][:search_type]
    send("#{@search_type}_search_results", params[:search])
  end

  def index

  end

private 
  def problem_search_results(params)
    # ::TODO_LATER::
    query = !params[:keywords].empty? ? params[:keywords] : "*"

    # pre-search, with topics: restrict problem id's beforehand
    id_restrictions = Problem.all.map(&:id)

    # topics
    topics = Topic.where(name: params[:topics].split(',').map(&:strip))
    topics.each { |t| id_restrictions &= t.problems_and_solutions_ids }

    #flags
    id_restrictions &= current_user.problems_marked_as_working_on.map(&:id) if params[:currently_working_on] == "1"
    id_restrictions &= current_user.problems_marked_as_solved.map(&:id)     if params[:solved_by_me] == "1"
    id_restrictions &= current_user.problems_marked_as_favorited.map(&:id)  if params[:favorited_by_me] == "1"

    # now build up query
    where_params = {}
    where_params[:or] = []
    where_params[:id] = id_restrictions

    #source
    where_params[:source] = params[:source] if params[:source] != ""

    #difficulty
    min_diff, max_diff = params[:min_difficulty].to_i, params[:max_difficulty].to_i
    difficulty_query = [{difficulty: {gte: min_diff, lte: max_diff}}]
    difficulty_query << {difficulty: -1} if true #accept undefined difficulties
    where_params[:or] << difficulty_query

    results = Problem.search query, fields: [:body, :source], where: where_params, limit: 50

    @results = []
    results.each do |r| 
      @results << r 
    end
  end

  def explanation_search_results(params)
    title = !params[:title].empty? ? params[:title] : "*"
    
    # ::TODO_LATER::
    results = Explanation.search title, fields: [:title]
    @results = []
    results.each do |r| 
      @results << r 
    end

    if params[:authors] != ""
      authors = Set.new(params[:authors].split(',').map(&:strip))
      @results.keep_if { |e| authors <= Set.new(e.authors) }
    end
    if params[:topics] != ""
      topics = Set.new(params[:topics].split(',').map(&:strip))
      @results.keep_if { |e| topics <= Set.new(e.specificest_topics.map(&:name)) }
    end
  end
end

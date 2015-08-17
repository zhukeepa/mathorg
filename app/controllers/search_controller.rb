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
    results = Problem.search query, fields: [:body, :source]
    @results = []
    results.each do |r| 
      @results << r 
    end

    #source
    @results.keep_if { |p| p.source == params[:source] } if params[:source] != ""

    #difficulty
    min_diff, max_diff = params[:min_difficulty].to_i, params[:max_difficulty].to_i
    @results.keep_if { |p| p.difficulty.nan? || 
      min_diff <= p.difficulty && p.difficulty <= max_diff }

    #flags
    @results.keep_if { |p| current_user.currently_working_on_problem?(p) } if params[:currently_working_on] == "1"
    @results.keep_if { |p| current_user.solved_problem?(p)  } if params[:solved_by_me] == "1"
    @results.keep_if { |p| current_user.favorited_problem?(p) } if params[:favorited_by_me] == "1"

    #topics
    if params[:topics] != ""
      topics = Set.new(params[:topics].split(',').map(&:strip))
      @results.keep_if { |p| topics <= Set.new(p.topics.map(&:name)) }
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
      @results.keep_if { |e| topics <= Set.new(e.topics.map(&:name)) }
    end
  end
end

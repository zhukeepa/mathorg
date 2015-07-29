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
    results = Problem.search params[:keywords], fields: [:body]
    @results = []
    results.each do |r| 
      @results << r 
    end

    if params[:source] != ""
      @results.keep_if { |p| p.source == params[:source] }
    end
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

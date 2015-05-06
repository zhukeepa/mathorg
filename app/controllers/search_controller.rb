class SearchController < ApplicationController
  def results
  	@search_type = params[:search][:search_type]
    send("#{@search_type}_search_results", params[:search])
  end

  def index

  end

private 
  def topic_search_results(params)
  	@topic_results = Topic.search(params[:name])
  end

  def problem_search_results(params)
    if params[:source] == ''
    	#@results = Problem.search params[:keywords], fields: [:description, :body]
      @results = Problem.all
    else
      @results = Problem.search params[:keywords], fields: [:description, :body], where: { source: [params[:source]]}
    end
  end
end

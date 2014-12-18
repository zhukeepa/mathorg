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
  	@problem_results = Problem.search params[:keywords], fields: [:description, :body]
  end
end

class SolutionsController < ApplicationController
  def edit
    @solution = Solution.find(params[:id])
  end

  def new
  	@solution = Solution.new
  end

  def create
  	@solution = Solution.new(params[:solution].permit(:body))
    @solution.problem = Problem.find(params[:solution][:problem_id])
    @topics = Topic.topics_string_to_topics_array(params[:solution][:topics])

    @solution.save
    @solution.topics << @topics
    
    redirect_to @solution.problem
  end

  def update
    @solution = Solution.find(params[:id])
    @topics = Topic.topics_string_to_topics_array(params[:solution][:topics])

    @solution.update(params[:solution].permit(:body))
    @solution.topics = @topics

    redirect_to @solution.problem
  end
end

class SolutionsController < ApplicationController
  def edit
    @solution = Solution.find(params[:id])
    @problem = Problem.find(params[:problem_id])
  end

  def new
  	@solution = Solution.new
    @problem = Problem.find(params[:problem_id])
  end

  def create
    @problem = Problem.find(params[:problem_id])
  	@solution = @problem.solutions.create(params[:solution].permit(:body))

    @solution.hints = Solution.hint_string_to_array(params[:solution][:hints])

    @topics = Topic.topics_string_to_topics_array(params[:solution][:topics])
    @solution.topics = @topics
    @solution.save
    
    redirect_to @problem
  end

  def update
    @solution = Solution.find(params[:id])
    @solution.update(params[:solution].permit(:body))

    ##::TODO:: maybe faster way to do this??
    @hints = Solution.hint_string_to_array(params[:solution][:hints])
    @solution.update({hints: @hints})

    @topics = Topic.topics_string_to_topics_array(params[:solution][:topics])
    @solution.topics = @topics

    redirect_to @solution.problem
  end
end

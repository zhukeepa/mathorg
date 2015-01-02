class SolutionsController < ApplicationController
  def edit
    @solution = Solution.find(params[:id])
    @problem = Problem.find(params[:problem_id])
  end

  def new
  	@solution = Solution.new
    @problem = Problem.find(params[:problem_id])
  end

  def comments
    @solution = Solution.find(params[:id])
    @comments = @solution.comments
  end

  def create
    @problem = Problem.find(params[:problem_id])
    
  	@solution = @problem.solutions.create(params[:solution].permit(:body, :hints_string))
    @solution.author = current_user
    @solution.topics = Topic.topics_string_to_topics_array(params[:solution][:topics])
    @solution.save
    
    redirect_to @problem
  end

  def update
    @solution = Solution.find(params[:id])
    @solution.update(params[:solution].permit(:body, :hints_string))
    @solution.topics = Topic.topics_string_to_topics_array(params[:solution][:topics])
    @solution.save

    redirect_to @solution.problem
  end

  def destroy
    @solution = Solution.find(params[:id])
    @solution.destroy

    render text: 'Your solution has been deleted.'
  end
end

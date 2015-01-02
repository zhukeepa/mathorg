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
    
  	@solution = @problem.solutions.create(solution_params)
    @solution.author = current_user
    @solution.save
    
    redirect_to @problem
  end

  def update
    @solution = Solution.find(params[:id])
    @solution.update(solution_params)

    redirect_to @solution.problem
  end

  def destroy
    @solution = Solution.find(params[:id])
    @solution.destroy

    render text: 'Your solution has been deleted.'
  end

private
  def solution_params
    params[:solution].permit(:body, :hints_string, :topics_string)
  end
end

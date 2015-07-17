class SolutionsController < ApplicationController
  before_action :set_problem, only: [:edit, :new, :create]
  before_action :set_solution, only: [:edit, :update, :comments, :destroy]
  before_action :authenticate_user!, except: [:comments]

  def edit
  end

  def new
  	@solution = Solution.new
  end

  def comments
    @comments = @solution.comments
  end

  def create
  	@solution = @problem.solutions.create(solution_params)
    @solution.author = current_user
    @solution.save
    
    redirect_to @problem
  end

  def update
    @solution.update(solution_params)

    redirect_to @solution.problem
  end

  def destroy
    @solution.destroy

    render text: 'Your solution has been deleted.'
  end

private
  def solution_params
    params.require(:solution).permit(:body, :hints_string, :topics_string)
  end

  def set_problem
    @problem = Problem.find(params[:problem_id])
  end

  def set_solution
    @solution = Solution.find(params[:id])
  end
end

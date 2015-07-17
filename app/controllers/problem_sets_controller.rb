class ProblemSetsController < ApplicationController
  before_action :set_problem_set, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def new
  	@ps = ProblemSet.new 
  end

  def edit
  end

  def index
    @problem_sets = ProblemSet.all
    @problem_sets = @problem_sets.sort_by(&:name)
  end

  def create
    @ps = ProblemSet.new(problem_set_params)

    if @ps.save
      redirect_to action: :show, id: @ps.name
    else 
      render 'new'
    end
  end

  def update
    if @ps.update(problem_set_params)
      redirect_to action: :show, id: @ps.name
    else
      render 'edit'
    end
  end

  def show
    @problems = @ps.problems
  end

  def destroy
    @ps.destroy

    render text: 'The problem set has been destroyed. '
  end

private
  def problem_set_params 
    params[:problem_set].permit(:name, :official, :problem_ids)
  end 
  
  def set_problem_set
    @ps = ProblemSet.find_by(name: params[:id])
  end
end

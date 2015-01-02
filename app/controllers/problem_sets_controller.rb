class ProblemSetsController < ApplicationController
  def new
  	@ps = ProblemSet.new 
  end

  def edit
    @ps = ProblemSet.find_by(name: params[:id])
  end

  def index
    @problem_sets = ProblemSet.all
    @problem_sets.sort_by!(&:name)
  end

  def create
    @ps = ProblemSet.new(params[:problem_set].permit(:name, :official))
    @ps.problems, @ps.problem_order = ProblemSet.problem_ids_string_to_problems_array_and_ordering(params[:problem_set][:problems])

    if @ps.save
      redirect_to action: :show, id: @ps.name
    else 
      render 'new'
    end
  end

  def update
    @ps = ProblemSet.find_by(name: params[:id])
      
    if @ps.update(params[:problem_set].permit(:name, :official, :problem_ids_string))
      redirect_to action: :show, id: @ps.name
    else
      render 'edit'
    end
  end

  def show
    @ps = ProblemSet.find_by(name: params[:id])
    @problems = @ps.problems_sorted
  end

  def destroy
    @ps = ProblemSet.find_by(name: params[:id])
    @ps.destroy

    render text: 'The problem set has been destroyed. '
  end
end

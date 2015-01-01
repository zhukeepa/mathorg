class ProblemSetsController < ApplicationController
  def new
  	@ps = ProblemSet.new 
  end

  def edit
    @ps = ProblemSet.find_by(name: params[:id])
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
    @ps.problems, @ps.problem_order = ProblemSet.problem_ids_string_to_problems_array_and_ordering(params[:problem_set][:problems])
      
    if @ps.update(params[:problem_set].permit(:name, :official))
      redirect_to action: :show, id: @ps.name
    else
      render 'edit'
    end
  end

  def show
    @ps = ProblemSet.find_by(name: params[:id])
    @problems = @ps.problem_ids.sort.map { |id| Problem.find(id) }
    @problems = ProblemSet.sort_array_by_order(@problems, @ps.problem_order)
  end

  def destroy
    @ps = ProblemSet.find_by(name: params[:id])
    @ps.destroy

    render text: 'The problem set has been destroyed. '
  end
end

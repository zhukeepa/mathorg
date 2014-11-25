class HintsetsController < ApplicationController
  def new
    @solution = Solution.find(params[:solution_id])
    @hintset = Hintset.new
  end

  def edit
  end

  def create
  	@solution = Solution.find(params[:solution_id])
    @hintset = @solution.hintsets.create(params[:hintset].permit(:hints))
    
    redirect_to @solution.problem
  end
end

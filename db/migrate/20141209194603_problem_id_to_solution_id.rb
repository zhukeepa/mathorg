class ProblemIdToSolutionId < ActiveRecord::Migration
  def change
  	remove_column :explanations, :problem_id
  	add_reference :explanations, :solution, index: true
  end
end
class RemoveSolutionFromExplanation < ActiveRecord::Migration
  def change
  	remove_column :explanations, :solution_id
  end
end

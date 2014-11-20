class AddProblemToExplanations < ActiveRecord::Migration
  def change
    add_reference :explanations, :problem, index: true
  end
end

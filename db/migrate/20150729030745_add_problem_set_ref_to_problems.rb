class AddProblemSetRefToProblems < ActiveRecord::Migration
  def change
    add_reference :problems, :problem_set, index: true, foreign_key: true
  end
end

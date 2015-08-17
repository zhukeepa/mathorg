class DropProblemSetsProblems < ActiveRecord::Migration
  def up
    drop_table :problem_sets_problems
  end

  def down
    raise ActiveRecord::IrreversibleMigration 
  end
end

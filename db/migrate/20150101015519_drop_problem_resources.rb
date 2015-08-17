class DropProblemResources < ActiveRecord::Migration
  def up
    drop_table :problem_resources
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

class DropOldTopicJoinTables < ActiveRecord::Migration
  def up
    drop_table :topic_explanations
    drop_table :topic_problems
    drop_table :topic_solutions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
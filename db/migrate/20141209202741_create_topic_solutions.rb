class CreateTopicSolutions < ActiveRecord::Migration
  def change
    create_table :topic_solutions do |t|
      t.float :weight
      t.integer :topic_id
      t.integer :solution_id

      t.timestamps
    end

    add_index :topic_solutions, :topic_id
    add_index :topic_solutions, :solution_id
  end
end

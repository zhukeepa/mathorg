class CreateTopicProblems < ActiveRecord::Migration
  def change
    create_table :topic_problems do |t|
      t.float :weight
      t.integer :topic_id
      t.integer :problem_id

      t.timestamps
    end

    add_index :topic_problems, :topic_id
    add_index :topic_problems, :problem_id
  end
end
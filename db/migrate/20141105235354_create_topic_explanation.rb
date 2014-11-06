class CreateTopicExplanation < ActiveRecord::Migration
  def change
    create_table :topic_explanations do |t|
    	t.integer :topic_id
    	t.integer :explanation_id
    end

    add_index :topic_explanations, :topic_id
    add_index :topic_explanations, :explanation_id
  end
end

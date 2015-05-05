class ChangeCategorizableToTopicable < ActiveRecord::Migration
  def change
    rename_table :topic_categorizables, :topic_topicables
    rename_column :topic_topicables, :categorizable_id, :topicable_id
    rename_column :topic_topicables, :categorizable_type, :topicable_type
    rename_index :topic_topicables, 'topic_categorizables_index', 'topic_topicables_index'
  end
end

class DropTopicChildParents < ActiveRecord::Migration
  def change
    drop_table :topic_child_parents
  end
end

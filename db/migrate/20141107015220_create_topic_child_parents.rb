class CreateTopicChildParents < ActiveRecord::Migration
  def change
    create_table :topic_child_parents do |t|
      t.float :weight
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
    add_index :topic_child_parents, :parent_id
    add_index :topic_child_parents, :child_id
  end
end

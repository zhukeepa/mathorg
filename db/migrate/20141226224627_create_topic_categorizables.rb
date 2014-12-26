class CreateTopicCategorizables < ActiveRecord::Migration
  def change
    create_table :topic_categorizables do |t|
      t.float :weight
      t.references :categorizable, polymorphic: true
      t.references :topic, index: true

      t.timestamps
    end

    add_index :topic_categorizables, ["categorizable_id"], name: 'topic_categorizables_index'
  end
end

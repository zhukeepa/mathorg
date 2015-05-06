class CreateExplanationAuthors < ActiveRecord::Migration
  def change
    create_table :explanation_authors do |t|
      t.float :weight
      t.integer :user_id
      t.integer :explanation_id

      t.timestamps
    end
  end
end

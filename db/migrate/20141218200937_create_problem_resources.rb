class CreateProblemResources < ActiveRecord::Migration
  def change
    create_table :problem_resources do |t|
      t.text :problem_ids
      t.string :title
      t.string :name

      t.timestamps
    end
  end
end

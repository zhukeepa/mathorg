class CreateProblemsProblemSets < ActiveRecord::Migration
  def change
    create_table :problem_sets do |t|
      t.text :problem_order
      t.string :name
      t.boolean :official

      t.timestamps 
    end

    create_table :problem_sets_problems, id: false do |t|
      t.references :problem,     index: true
      t.references :problem_set, index: true
    end
  end
end

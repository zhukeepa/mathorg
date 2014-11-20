class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.text :body
      t.string :source
      t.string :author
      t.boolean :show_solution

      t.timestamps
    end
  end
end

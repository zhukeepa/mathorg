class CreateExplanations < ActiveRecord::Migration
  def change
    create_table :explanations do |t|
      t.text :description
      t.string :title
      t.integer :depth
      t.string :ordering

      t.timestamps
    end
  end
end

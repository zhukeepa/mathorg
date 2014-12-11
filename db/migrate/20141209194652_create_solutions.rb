class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :hints
      t.references :problem, index: true

      t.timestamps
    end
  end
end

class CreateHintsets < ActiveRecord::Migration
  def change
    create_table :hintsets do |t|
      t.text :hints
      t.references :solution, index: true

      t.timestamps
    end
  end
end

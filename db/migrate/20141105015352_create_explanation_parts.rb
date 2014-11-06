class CreateExplanationParts < ActiveRecord::Migration
  def change
    create_table :explanation_parts do |t|

      t.timestamps
    end
  end
end

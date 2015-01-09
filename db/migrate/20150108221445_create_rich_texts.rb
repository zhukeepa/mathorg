class CreateRichTexts < ActiveRecord::Migration
  def change
    create_table :rich_texts do |t|
      t.text :text
      t.references :bodyable, :polymorphic => true

      t.timestamps
    end
  end
end

class DropHintsetTable < ActiveRecord::Migration
  def up
    drop_table :hintsets
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

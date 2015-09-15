class DropLocals < ActiveRecord::Migration
  def change
    remove_column :eventos, :local_id, index: true
    remove_column :lojas, :local_id, index: true
    remove_column :pistas, :local_id, index: true
    drop_table :locals
  end
end

class AlterHorarios < ActiveRecord::Migration
  def change
    add_column :horarios, :seg, :boolean
    add_column :horarios, :ter, :boolean
    add_column :horarios, :qua, :boolean
    add_column :horarios, :qui, :boolean
    add_column :horarios, :sex, :boolean
    add_column :horarios, :sab, :boolean
    add_column :horarios, :dom, :boolean
    
    add_column :horarios, :detalhes, :string, :limit => 100
    
    remove_column :horarios, :dias
    remove_column :horarios, :periodo
  end
end

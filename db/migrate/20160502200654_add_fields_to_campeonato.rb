class AddFieldsToCampeonato < ActiveRecord::Migration
  def change
    add_column :campeonatos, :nome, :string
    add_column :campeonatos, :data_inicio, :date
    add_column :campeonatos, :data_fim, :date
    add_column :campeonatos, :hora, :time
    add_column :campeonatos, :descricao, :string
    add_reference :campeonatos, :responsavel, index: true
  end
end

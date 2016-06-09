class AddMaxAndMinCompetitorsToCampeonato < ActiveRecord::Migration
  def change
    add_column :campeonatos, :max_competidores_categoria, :integer
    add_column :campeonatos, :min_competidores_categoria, :integer
    add_column :campeonatos, :max_competidores_prova, :integer
    add_column :campeonatos, :min_competidores_prova, :integer
    add_column :campeonatos, :num_vencedores_prova, :integer
  end
end

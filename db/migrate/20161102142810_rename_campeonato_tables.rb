class RenameCampeonatoTables < ActiveRecord::Migration
  def change
    rename_table :categorias, :campeonato_categorias
    rename_table :etapas, :campeonato_etapas
    rename_table :inscricoes, :campeonato_inscricoes
    rename_table :participantes, :campeonato_participantes
    rename_table :provas_participantes, :campeonato_provas_participantes
  end
end

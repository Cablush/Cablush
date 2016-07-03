class RemoveFieldsEtapa < ActiveRecord::Migration
  def change
	remove_column :etapas, :qtdProvas
	remove_column :etapas, :numCompetidoresProva
  end
end

class AddFieldsToEtapa < ActiveRecord::Migration
  def change
    add_column :etapas, :qtdProvas, :integer
    add_column :etapas, :numCompetidoresProva, :integer
  end
end

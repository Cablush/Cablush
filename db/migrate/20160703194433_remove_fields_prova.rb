class RemoveFieldsProva < ActiveRecord::Migration
  def change
  	remove_column :provas, :etapa_id
  end
end

class RemoveFieldsProva < ActiveRecord::Migration
  def change
  	remove_column :provas, :participantes_id
  end
end

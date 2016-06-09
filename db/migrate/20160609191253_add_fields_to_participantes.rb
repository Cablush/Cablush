class AddFieldsToParticipantes < ActiveRecord::Migration
  def change
    add_column :participantes, :numero_inscricao, :integer
    add_reference :participantes, :categoria, index: true, foreign_key: true
    add_column :participantes, :classificacao, :string
  end
end

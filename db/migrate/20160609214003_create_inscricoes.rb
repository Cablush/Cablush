class CreateInscricaos < ActiveRecord::Migration
  def change
    create_table :inscricoes do |t|
      t.string :nome
      t.string :tipo_documento
      t.string :documento
      t.string :arquivo_documento
      t.string :foto
      t.string :email
      t.references :campeonato, index: true, foreign_key: true
      t.references :categoria, index: true, foreign_key: true
      t.integer :numero_inscricao
      t.string :tipo_pagamento
      t.decimal :valor_pagamento

      t.timestamps null: false
    end
  end
end

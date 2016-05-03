class CreateParticipantes < ActiveRecord::Migration
  def change
    create_table :participantes do |t|
      t.string :nome
      t.string :uuid
      t.references :usuario, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

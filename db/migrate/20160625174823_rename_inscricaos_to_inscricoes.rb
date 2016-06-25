class RenameInscricaosToInscricoes < ActiveRecord::Migration
  def change
    rename_table :inscricaos, :inscricoes
  end
end

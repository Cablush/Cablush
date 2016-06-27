class AddUuidToCampeonato < ActiveRecord::Migration
  def self.up
    add_column :campeonatos, :uuid, :string

    Campeonato.reset_column_information

    Campeonato.all.each do |campeonato|
      campeonato.uuid = SecureRandom.uuid
      campeonato.save!
    end

    change_column :campeonatos, :uuid, :string, :null => false
    add_index :campeonatos, :uuid, unique: true
  end

  def self.down
    remove_column :campeonatos, :uuid
  end
end

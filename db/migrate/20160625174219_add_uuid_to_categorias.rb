class AddUuidToCategorias < ActiveRecord::Migration
  def self.up
    add_column :categorias, :uuid, :string

    Categoria.reset_column_information

    Categoria.all.each do |c|
      c.uuid = SecureRandom.uuid
      c.save!
    end

    change_column :categorias, :uuid, :string, :null => false
    add_index :categorias, :uuid, unique: true
  end

  def self.down
    remove_column :categorias, :uuid
  end
end

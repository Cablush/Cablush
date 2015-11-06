class FixColumnSizes < ActiveRecord::Migration
  def change
    # Local
    change_column :locais, :logradouro, :string, :limit => 100
    change_column :locais, :numero, :string, :limit => 10
    change_column :locais, :complemento, :string, :limit => 25
    change_column :locais, :bairro, :string, :limit => 100
    change_column :locais, :cidade, :string, :limit => 100
    change_column :locais, :estado, :string, :limit => 2
    change_column :locais, :cep, :string, :limit => 10
    change_column :locais, :pais, :string, :limit => 2
    # Loja
    change_column :lojas, :nome, :string, :limit => 50
    change_column :lojas, :descricao, :string, :limit => 500
    change_column :lojas, :telefone, :string, :limit => 20
    change_column :lojas, :email, :string, :limit => 50
    change_column :lojas, :website, :string, :limit => 150
    change_column :lojas, :facebook, :string, :limit => 150
    # Pista
    change_column :pistas, :nome, :string, :limit => 50
    change_column :pistas, :descricao, :string, :limit => 500
    change_column :pistas, :website, :string, :limit => 150
    change_column :pistas, :facebook, :string, :limit => 150
    # Evento
    change_column :eventos, :nome, :string, :limit => 50
    change_column :eventos, :descricao, :string, :limit => 500
    change_column :eventos, :website, :string, :limit => 150
    change_column :eventos, :facebook, :string, :limit => 150
  end
end

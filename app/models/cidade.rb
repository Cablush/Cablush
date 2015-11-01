class Cidade < ActiveRecord::Base

  belongs_to :estado
  
  scope :find_like_nome, ->(nome) {
    where('cidades.nome LIKE ?', "#{nome}%") if nome.present?
  }
  
  scope :from_estado, ->(estado) { 
    joins(:estado).where('estados.rg = ?', "#{estado}") if estado.present? 
  }
  
  def self.save?(nome_cidade, estado_cidade) 
    if Cidade.from_estado(estado_cidade).find_by_nome(nome_cidade).blank?
      estado = Estado.find_by_rg(estado_cidade)
      if estado.present?
        Cidade.create(nome: nome_cidade, estado: estado)
      end
    end
  end
  
  def cidade_estado
    self.nome + " / " + self.estado.rg
  end
  
end

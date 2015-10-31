class Cidade < ActiveRecord::Base
  belongs_to :estado
  
  scope :find_like_nome, ->(nome) {
    where('cidades.nome LIKE ?', "#{nome}%") if nome.present?
  }
  
  scope :from_estado, ->(estado) { 
    joins(:estado).where('estados.rg = ?', "#{estado}") if estado.present? 
  }
  
  def cidade_estado
    self.nome + " / " + self.estado.rg
  end
  
end

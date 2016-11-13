class Cidade < ActiveRecord::Base
  belongs_to :estado, class_name: 'Estado'

  scope :find_like_nome, ->(nome) {
    where('cidades.nome LIKE ?', "#{nome}%") if nome.present?
  }

  scope :from_estado, ->(estado) {
    joins(:estado).where('estados.rg = ?', "#{estado}") if estado.present?
  }

  def self.save?(nome_cidade, rg_estado)
    if Cidade.from_estado(rg_estado).find_by_nome(nome_cidade).blank?
      estado = Estado.find_by_rg(rg_estado)
      Cidade.create(nome: nome_cidade, estado: estado) if estado.present?
    end
  end

  def cidade_estado
    nome + ' / ' + estado.rg
  end
end

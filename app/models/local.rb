class Local < ActiveRecord::Base

  belongs_to :localizavel, polymorphic: true
  
  # Permite fazer join com os modelos localizaveis
  belongs_to :loja, -> { where(locais: {localizavel_type: 'Loja'}) }, foreign_key: 'localizavel_id'
  belongs_to :pista, -> { where(locais: {localizavel_type: 'Pista'}) }, foreign_key: 'localizavel_id'
  belongs_to :evento, -> { where(locais: {localizavel_type: 'Evento'}) }, foreign_key: 'localizavel_id'
  
  scope :lojas, -> { joins(loja: :esportes) }
  scope :pistas, -> { joins(pista: :esportes) }
  scope :eventos, -> { joins(evento: :esportes) }
  
  def self.lojas_by_estado(estado)
    joins(loja: :esportes).where(estado: estado)
  end
  
  def self.lojas_by_esporte(esporte_id)
    joins(loja: :esportes).where(esportes: {id: esporte_id})
  end
  
  def self.pistas_by_estado(estado)
    joins(pista: :esportes).where(estado: estado)
  end
  
  def self.pistas_by_esporte(esporte_id)
    joins(pista: :esportes).where(esportes: {id: esporte_id})
  end
  
  def self.eventos_by_estado(estado)
    joins(evento: :esportes).where(estado: estado)
  end
  
  def self.eventos_by_esporte(esporte_id)
    joins(evento: :esportes).where(esportes: {id: esporte_id})
  end
  
  def endereco
    ender = ''
    ender = ender.try_append(logradouro)
    ender = ender.try_append(numero, ', ')
    ender = ender.try_append(complemento, ', ')
    ender = ender.try_append(bairro, ', ')
    ender = ender.try_append(cidade, '\n')
    ender = ender.try_append(estado, ' / ')
    ender = ender.try_append(cep, '\n')
    ender = ender.try_append(pais, '\n')
    ender
  end
  
end

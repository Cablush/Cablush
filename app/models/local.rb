class Local < ActiveRecord::Base

  belongs_to :localizavel, polymorphic: true
  
  # Permite fazer join com os modelos localizaveis
  belongs_to :loja, -> { where(locais: {localizavel_type: 'Loja'}) }, foreign_key: 'localizavel_id'
  belongs_to :pista, -> { where(locais: {localizavel_type: 'Pista'}) }, foreign_key: 'localizavel_id'
  belongs_to :evento, -> { where(locais: {localizavel_type: 'Evento'}) }, foreign_key: 'localizavel_id'
  
  scope :lojas, -> { joins(:loja) }
  scope :pistas, -> { joins(:pista) }
  scope :eventos, -> { joins(:evento).where('eventos.data_fim >= ?', Date.today) }
  
  scope :lojas_by_estado, ->(estado) {
    lojas.where(estado: estado)
  }
  
  scope :lojas_by_esporte, ->(esporte_id) {
    joins(loja: :esportes).where(esportes: {id: esporte_id})
  }
  
  scope :pistas_by_estado, ->(estado) {
    pistas.where(estado: estado)
  }
  
  scope :pistas_by_esporte, ->(esporte_id) {
    joins(pista: :esportes).where(esportes: {id: esporte_id})
  }
  
  scope :eventos_by_estado, ->(estado) {
    eventos.where(estado: estado)
  }
  
  scope :eventos_by_esporte, ->(esporte_id) {
    joins(evento: :esportes).where(esportes: {id: esporte_id})
  }
  
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
  
  def loja?
    localizavel_type == 'Loja'
  end
  
  def pista?
    localizavel_type == 'Pista'
  end
  
  def evento?
    localizavel_type == 'Evento'
  end
  
end

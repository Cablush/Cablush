class Local < ActiveRecord::Base
  
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :logradouro, presence: true, length: { maximum: 100 }
  validates :numero, length: { maximum: 10 }
  validates :complemento, length: { maximum: 25 }
  validates :bairro, length: { maximum: 100 }
  validates :cidade, presence: true, length: { maximum: 100 }
  validates :estado, presence: true, length: { maximum: 2 }
  validates :cep, length: { maximum: 10 }
  validates :pais, length: { maximum: 2 }
  
  after_save :save_cidade
  
  belongs_to :localizavel, polymorphic: true
  
  # Permite fazer join com os modelos localizaveis
  belongs_to :loja, -> { where(locais: {localizavel_type: 'Loja'}) }, foreign_key: 'localizavel_id'
  belongs_to :pista, -> { where(locais: {localizavel_type: 'Pista'}) }, foreign_key: 'localizavel_id'
  belongs_to :evento, -> { where(locais: {localizavel_type: 'Evento'}) }, foreign_key: 'localizavel_id'
  
  scope :lojas, -> { joins(:loja) }
  scope :pistas, -> { joins(:pista) }
  scope :eventos, -> { joins(:evento).merge(Evento.actives_ordered) }
  
  scope :lojas_by_estado, ->(estado) {
    lojas.where(estado: estado)
  }
  
  scope :lojas_by_esporte_categoria, ->(categoria) {
    lojas.merge(Loja.find_by_esporte_categoria(categoria))
  }
  
  scope :pistas_by_estado, ->(estado) {
    pistas.where(estado: estado)
  }
  
  scope :pistas_by_esporte_categoria, ->(categoria) {
    pistas.merge(Pista.find_by_espporte_categoria(categoria))
  }
  
  scope :eventos_by_estado, ->(estado) {
    eventos.where(estado: estado)
  }
  
  scope :eventos_by_esporte_categoria, ->(categoria) {
    eventos.merge(Evento.find_by_esporte_categoria(categoria))
  }
  
  def self.localizaveis_active
    l, e = arel_table, Evento.arel_table
    predicate = l.join(e).on(l[:localizavel_id].eq(e[:id]))
    
    joins(predicate.join_sources)
    .where("(localizavel_type != 'Evento') OR ((localizavel_type = 'Evento') AND (eventos.data_fim >= ?))", 
           Date.today)
  end
  
  def endereco
    ender = ''
    ender = ender.try_append(logradouro)
    ender = ender.try_append(numero, ', ')
    ender = ender.try_append(complemento, ', ')
    ender = ender.try_append(bairro, '\n')
    ender = ender.try_append(cidade, '\n')
    ender = ender.try_append(estado, ' / ')
    ender = ender.try_append(cep, '\n')
    ender = ender.try_append(pais, '\n')
    ender.gsub(/\\n/, '<br>').html_safe
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
  
  private
  
  def save_cidade
    if cep.present? && cidade.present? && estado.present?
      Cidade.save?(cidade, estado)
    end
  end
  
end

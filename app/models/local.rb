class Local < ActiveRecord::Base
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :logradouro, length: { maximum: 100 }
  validates :numero, length: { maximum: 10 }
  validates :complemento, length: { maximum: 25 }
  validates :bairro, length: { maximum: 100 }
  validates :cidade, presence: true, length: { maximum: 100 }
  validates :estado, presence: true, length: { maximum: 2 }
  validates :cep, length: { maximum: 10 }
  validates :pais, presence: true, length: { maximum: 2 }

  attr_accessor :estado_nome, :pais_nome

  after_save :save_estado_cidade

  after_initialize :load_full_address

  belongs_to :localizavel, polymorphic: true

  # Permite fazer join com os modelos localizaveis
  belongs_to :loja, -> {
    where(locais: { localizavel_type: 'Loja' })
  }, foreign_key: 'localizavel_id'
  belongs_to :pista, -> {
    where(locais: { localizavel_type: 'Pista' })
  }, foreign_key: 'localizavel_id'
  belongs_to :evento, -> {
    where(locais: { localizavel_type: 'Evento' })
  }, foreign_key: 'localizavel_id'
  belongs_to :campeonato, -> {
    where(locais: { localizavel_type: 'Campeonato' })
  }, foreign_key: 'localizavel_id'

  scope :lojas, -> { joins(:loja) }
  scope :pistas, -> { joins(:pista) }
  scope :eventos, -> {
    joins(:evento).merge(Evento.actives_ordered)
  }
  scope :campeonatos, -> {
    joins(:campeonato).merge(Campeonato.actives_ordered)
  }

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
    pistas.merge(Pista.find_by_esporte_categoria(categoria))
  }

  scope :eventos_by_estado, ->(estado) {
    eventos.where(estado: estado)
  }

  scope :eventos_by_esporte_categoria, ->(categoria) {
    eventos.merge(Evento.find_by_esporte_categoria(categoria))
  }

  scope :cameponatos_by_estado, ->(estado) {
    cameponatos.where(estado: estado)
  }

  scope :cameponatos_by_esporte_categoria, ->(categoria) {
    cameponatos.merge(Cameponato.find_by_esporte_categoria(categoria))
  }

  def self.localizaveis_active
    local, evento = arel_table, Evento.arel_table
    predicate = local.join(evento, Arel::Nodes::OuterJoin)
                     .on(local[:localizavel_id].eq(evento[:id]))

    joins(predicate.join_sources).where("(localizavel_type != 'Evento')
      OR ((localizavel_type = 'Evento')
      AND (eventos.data_fim >= ?))", Date.today)
  end

  def endereco
    ender = ''
    ender = ender.try_append(logradouro)
    ender = ender.try_append(numero, ', ')
    ender = ender.try_append(complemento, ', ')
    ender = ender.try_append(bairro, '\n')
    ender = ender.try_append(cidade, '\n')
    ender = ender.try_append(estado_nome, ' / ')
    ender = ender.try_append(cep, '\n')
    ender = ender.try_append(pais_nome, '\n')
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

  def campeonato?
    localizavel_type == 'Campeonato'
  end

  private

  def save_estado_cidade
    if pais.present? && estado.present?
      Estado.save?(estado, estado_nome, pais)
    end
    if cep.present? && estado.present? && cidade.present?
      Cidade.save?(cidade, estado)
    end
  end

  def load_full_address
    unless new_record?
      if pais.present?
        pais_obj = Country.find_by_iso(pais)
        self.pais_nome = pais_obj.name if pais_obj.present?
        if estado.present?
          estado_obj = Estado.from_country(pais).find_by_rg(estado)
          self.estado_nome = estado_obj.nome if estado_obj.present?
        end
      end
    end
  end
end

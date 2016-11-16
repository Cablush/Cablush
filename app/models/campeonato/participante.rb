class Campeonato::Participante < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :campeonato
  belongs_to :categoria

  has_many :provas_participantes
  has_many :provas, through: :provas_participantes

  before_create :set_uuid

  validates :nome, presence: true, length: { maximum: 50 }
  validates :numero_inscricao, presence: true, numericality: true,
                               uniqueness: { scope: :campeonato }
  validates :classificacao, presence: true, numericality: true,
                            uniqueness: { scope: :categoria }
  validates_associated :usuario
  validates_associated :categoria

  scope :ordered_by_classificacao, -> {
    order('classificacao ASC')
  }

  scope :in_etapa, ->(etapa_id) {
    joins(provas_participantes: :prova)
    .where('campeonato_provas.etapa_id = ?', etapa_id)
  }

  def categoria_id
    categoria.id
  end

  def campeonato_id
    campeonato.id
  end

  def next_prova
    provas_participantes.next.prova_id if provas_participantes.any?
  end

  def as_json(options={})
    super(only: [:nome, :numero_inscricao, :classificacao, :uuid],
          methods: [:categoria_id, :campeonato_id, :next_prova]
    )
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end

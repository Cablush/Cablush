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

  def categoria_id
    categoria.id
  end

  def as_json(options={})
    super(only: [:nome, :numero_inscricao, :classificacao, :uuid],
          methods: [:categoria_id]
    )
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end

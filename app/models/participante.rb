class Participante < ActiveRecord::Base
  
  has_many :provas_participantes
  has_many :provas, through: :provas_participantes

  belongs_to :usuario
  belongs_to :categoria

  before_create :set_uuid

  validates :nome, presence: true, length: { maximum: 50 }
  validates :numero_inscricao, presence: true, numericality: true
  validates_associated :usuario
  validates :classificacao, presence: true, numericality: true
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

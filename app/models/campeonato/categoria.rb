class Campeonato::Categoria < ActiveRecord::Base
  belongs_to :campeonato

  has_many :participantes
  has_many :etapas

  before_create :set_uuid

  validates :nome, presence: true, length: { maximum: 50 }
  validates :descricao, presence: true, length: { maximum: 500 }
  validates :regras, presence: true, length: { maximum: 1000 }

  def to_param
    uuid
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end

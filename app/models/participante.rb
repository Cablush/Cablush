class Participante < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :categoria

  before_create :set_uuid

  validates :nome, presence: true, length: { maximum: 50 }
  validates :numero_inscricao, presence: true, numericality: true
  validates_associated :usuario
  validates :classificacao, presence: true, numericality: true
  validates_associated :categoria

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end

end

class Categoria < ActiveRecord::Base
  belongs_to :campeonato
  has_many :participantes

  before_create :set_uuid

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end

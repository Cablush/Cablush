class Campeonato::Categoria < ActiveRecord::Base
  belongs_to :campeonato

  has_many :participantes
  has_many :etapas, dependent: :destroy

  before_create :set_uuid

  validates :nome, presence: true, length: { maximum: 50 }
  validates :descricao, presence: true, length: { maximum: 500 }
  validates :regras, presence: true, length: { maximum: 1000 }

  def to_param
    uuid
  end

  def generate_etapas
    if etapas.empty?
      num_competidores = max_competidores_categoria
      while num_competidores >= max_competidores_prova
        etapa = Campeonato::Etapa.generate_etapa(self, num_competidores)
        num_competidores = etapa.num_provas * num_vencedores_prova
      end
    end
  end

  def max_competidores_categoria
    campeonato.max_competidores_categoria
  end

  def max_competidores_prova
    campeonato.max_competidores_prova
  end

  def num_vencedores_prova
    campeonato.num_vencedores_prova
  end

  def campeonato_id
    campeonato.id
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end

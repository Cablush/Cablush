class Campeonato < ActiveRecord::Base

  belongs_to :responsavel, class_name: "Usuario"

  has_many :etapas, dependent: :destroy
  accepts_nested_attributes_for :etapas, allow_destroy: true

  has_many :categorias, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :categorias, allow_destroy: true,
    reject_if: proc { |att| att['nome'].blank? }

  has_one :horario, as: :funcionamento, dependent: :destroy
  accepts_nested_attributes_for :horario, allow_destroy: true

  has_and_belongs_to_many :esportes
  has_and_belongs_to_many :eventos

  is_impressionable
  before_create :set_uuid

  def to_param
    uuid
  end

  validates :nome, presence: true, length: { maximum: 50 }
  validates :descricao, presence: true, length: { maximum: 500 }
  validates :data_inicio, presence: true
  validates :hora, presence: true
  validates :data_fim, presence: true
  validates :max_competidores_categoria, presence: true
  validates :min_competidores_categoria, presence: true
  validates :max_competidores_prova, presence: true
  validates :min_competidores_prova, presence: true
  validates :num_vencedores_prova, presence: true
  #validates :categorias, presence: true
  #validates_associated :categorias
  #validates :esportes, presence: true

  scope :find_like_name, ->(nome) {
    where('campeonato.nome LIKE ?', "#{nome}%") if nome.present?
  }

  def responsavel_uuid
    responsavel.uuid
  end

  def as_json(options={})
    super(only: [:nome, :descricao, :uuid, :data_inicio, :hora, :data_fim,
      :max_competidores_categoria, :min_competidores_categoria,
      :max_competidores_prova, :min_competidores_prova, :num_vencedores_prova],
      methods: [:responsavel_uuid],
      include: {
        categorias: {except: [:id, :created_at, :updated_at]},
        esportes: {except: [:created_at, :updated_at]},
      }
    )
  end

  def share_message
    return I18n.t('views.campeonatos.share', campeonato: nome)
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end

end

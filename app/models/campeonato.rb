class Campeonato < ActiveRecord::Base
  belongs_to :responsavel, class_name: 'Usuario'

  has_one :local, as: :localizavel, dependent: :destroy
  accepts_nested_attributes_for :local, allow_destroy: true

  has_one :horario, as: :funcionamento, dependent: :destroy
  accepts_nested_attributes_for :horario, allow_destroy: true

  has_and_belongs_to_many :esportes

  has_one :evento

  has_many :categorias, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :categorias, allow_destroy: true,
                                reject_if: proc { |att| att['nome'].blank? }

  has_many :etapas, dependent: :destroy
  accepts_nested_attributes_for :etapas, allow_destroy: true

  has_many :participantes

  has_attached_file :flyer,
                    styles: {
                      small: '340x200>',
                      original: '800x600>'
                    }

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
  validates :categorias, presence: true
  validates_associated :categorias
  validates :esportes, presence: true
  validates :local, presence: true
  validates_associated :local
  validates :responsavel, presence: true
  validates_attachment :flyer,
                       size: { in: 0..5.megabytes },
                       content_type: { content_type: /^image\/(jpeg|png)$/ }

  scope :actives_ordered, -> {
    where('campeonatos.data_fim >= ?', Date.today).order('data')
  }

  scope :find_like_name, ->(nome) {
    where('campeonatos.nome LIKE ?', "#{nome}%") if nome.present?
  }

  scope :find_by_estado, ->(estado) {
    joins(:local).where('locais.estado = ?', estado) if estado.present?
  }

  scope :find_by_esporte_categoria, ->(categoria) {
    joins(:esportes).where(esportes: { categoria: categoria })
                    .distinct if categoria.present?
  }

  def datas
    datas_tmp = data_inicio.strftime('%d/%m/%Y')
    datas_tmp = datas_tmp.try_append(data_fim.strftime('%d/%m/%Y'), ' A ')
    datas_tmp
  end

  def horario
    hora.strftime('%H:%M')
  end

  def start_date
    (data_inicio.to_s + ' ' + hora.to_s).to_datetime
  end

  def flyer_url
    if flyer.exists?
      flyer.url(:original).sub(/\?\d+$/, '')
    end
  end

  def responsavel_uuid
    responsavel.uuid
  end

  def as_json(options={})
    super(only: [:nome, :descricao, :uuid, :data_inicio, :hora, :data_fim,
                 :max_competidores_categoria, :min_competidores_categoria,
                 :max_competidores_prova, :min_competidores_prova,
                 :num_vencedores_prova],
          methods: [:responsavel_uuid],
          include: {
            categorias: { except: [:id, :created_at, :updated_at] },
            esportes: { except: [:created_at, :updated_at] },
            local: { except: [:id, :localizavel_id, :localizavel_type,
                              :created_at, :updated_at] }
          }
    )
  end

  def share_message
    I18n.t('views.campeonatos.share', campeonato: nome)
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end

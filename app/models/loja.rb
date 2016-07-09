class Loja < ActiveRecord::Base
  belongs_to :responsavel, class_name: 'Usuario'

  has_many :locais, as: :localizavel, dependent: :destroy
  accepts_nested_attributes_for :locais, allow_destroy: true

  has_one :horario, as: :funcionamento, dependent: :destroy
  accepts_nested_attributes_for :horario, allow_destroy: true

  has_and_belongs_to_many :esportes
  has_and_belongs_to_many :eventos

  has_attached_file :logo,
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
  validates :telefone, length: { maximum: 20 }
  validates :email, length: { maximum: 50 }, allow_blank: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :website, length: { maximum: 150 }
  validates :facebook, length: { maximum: 150 }
  validates :locais, presence: true
  validates_associated :locais
  validates :esportes, presence: true
  validates :responsavel, presence: true
  validates_attachment :logo,
                       size: { in: 0..5.megabytes },
                       content_type: { content_type: /^image\/(jpeg|png)$/ }

  scope :find_like_name, ->(nome) {
    where('lojas.nome LIKE ?', "#{nome}%") if nome.present?
  }

  scope :find_by_estado, ->(estado) {
    joins(:locais).where('locais.estado = ?', estado) if estado.present?
  }

  scope :find_by_esporte_categoria, ->(categoria) {
    joins(:esportes).where(esportes: { categoria: categoria })
                    .distinct if categoria.present?
  }

  def contato
    contato = telefone
    contato += ' / ' if contato.present?
    contato += email
    return contato
  end

  def logo_url
    if logo.exists?
      logo.url(:original).sub(/\?\d+$/, '')
    end
  end

  def responsavel_uuid
    responsavel.uuid
  end

  def as_json(options={})
    super(only: [:nome, :descricao, :telefone, :email, :website, :facebook,
                 :uuid],
          methods: [:logo_url, :responsavel_uuid],
          include: {
            locais: { except: [:id, :localizavel_id, :localizavel_type,
                               :created_at, :updated_at] },
            esportes: { except: [:created_at, :updated_at] },
            horario: { except: [:id, :funcionamento_id, :funcionamento_type,
                                :created_at, :updated_at] }
          }
    )
  end

  def share_message
    I18n.t('views.lojas.share', loja: nome)
  end

  def local
    locais[0]
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end

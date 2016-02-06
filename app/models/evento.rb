class Evento < ActiveRecord::Base
  
  belongs_to :responsavel, class_name: "Usuario"
  
  has_one :local, as: :localizavel, dependent: :destroy
  accepts_nested_attributes_for :local, allow_destroy: true
                              
  has_and_belongs_to_many :esportes
  
  before_create :set_uuid
  
  def to_param
    uuid
  end
  
  validates :nome, presence: true, length: { maximum: 50 }
  validates :descricao, length: { maximum: 500 }
  validates :data, presence: true
  validates :hora, presence: true
  validates :website, length: { maximum: 150 }
  validates :facebook, length: { maximum: 150 }
  validates :data_fim, presence: true
  validates :local, presence: true
  validates_associated :local
  validates :esportes, presence: true
  
  has_attached_file :flyer, 
                    :styles => { 
                      :small => "340x200>",
                      :original => "800x600>"
                    }
                    
  scope :visible, -> { where('eventos.data_fim >= ?', Date.today) }

  scope :find_like_name, ->(nome) {
    where('eventos.nome LIKE ?', "%#{nome}%") if nome.present?
  }
  
  scope :find_by_estado, ->(estado) {
    joins(:local).where('locais.estado = ?', estado) if estado.present?
  }
  
  scope :find_by_esporte_categoria, ->(categoria) {
    joins(:esportes).where(esportes: {categoria: categoria}).distinct if categoria.present?
  }

  validates_attachment :flyer, 
    :size => { :in => 0..5.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png)$/ }
    
  #  scope :public, -> { where(public: true) }
  #  scope :sponsored, -> { where(patrocinado: true) }
  
  def horario
    data.strftime('%d/%m/%Y') + " às " + hora.strftime('%H:%M')
  end
  
  def flyer_url
    url = flyer.url(:original)
    if !url.include? "missing.png"
      url.sub /\?\d+$/, ''
    end
  end
  
  private
  
  def set_uuid
    self.uuid = SecureRandom.uuid
  end
  
end

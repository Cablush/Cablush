class Pista < ActiveRecord::Base
  
  belongs_to :responsavel, class_name: "Usuario"
  
  has_one :local, as: :localizavel, dependent: :destroy
  accepts_nested_attributes_for :local, allow_destroy: true
    
  has_one :horario, as: :funcionamento, dependent: :destroy
  accepts_nested_attributes_for :horario, allow_destroy: true
  
  has_and_belongs_to_many :esportes
  
  before_create :set_uuid
  
  def to_param
    uuid
  end
  
  validates :nome, presence: true, length: { maximum: 50 }
  validates :descricao, length: { maximum: 500 }
  validates :website, length: { maximum: 150 }
  validates :facebook, length: { maximum: 150 }
  validates :local, presence: true
  validates_associated :local
  validates :esportes, presence: true
  
  has_attached_file :foto, 
                    :styles => { 
                      :small => "340x200>",
                      :original => "1024x768>"
                    }

  validates_attachment :foto, 
    :size => { :in => 0..5.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png)$/ }
  
  scope :find_like_name, ->(nome) {
    where('pistas.nome LIKE ?', "%#{nome}%") if nome.present?
  }
  
  scope :find_by_estado, ->(estado) {
    joins(:locais).where(locais: {estado: estado}) if estado.present?
  }
  
  scope :find_by_esporte_id, ->(esporte_id) {
    joins(:esportes).where(esportes: {id: esporte_id}) if esporte_id.present?
  }

  private
  
  def set_uuid
    self.uuid = SecureRandom.uuid
  end
  
end

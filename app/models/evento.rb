class Evento < ActiveRecord::Base
  
  belongs_to :responsavel, class_name: "Usuario"
  
  has_one :local, as: :localizavel, dependent: :destroy
  accepts_nested_attributes_for :local, 
                                reject_if: proc { |attributes| attributes['logradouro'].blank? },
                                allow_destroy: true
                              
  has_and_belongs_to_many :esportes
  
  before_create :set_uuid
  
  def to_param
    uuid
  end
  
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
    joins(:locais).where(locais: {estado: estado}) if estado.present?
  }
  
  scope :find_by_esporte_id, ->(esporte_id) {
    joins(:esportes).where(esportes: {id: esporte_id}) if esporte_id.present?
  }

  validates_attachment :flyer, 
    :size => { :in => 0..5.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png)$/ }
    
  #  scope :public, -> { where(public: true) }
  #  scope :sponsored, -> { where(patrocinado: true) }
  
  def horario
    data.strftime('%d/%m/%Y') + " às " + hora.strftime('%H:%M')
  end
  
  private
  
  def set_uuid
    self.uuid = SecureRandom.uuid
  end
  
end

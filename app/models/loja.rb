class Loja < ActiveRecord::Base
  
  belongs_to :responsavel, class_name: "Usuario"
  
  has_many :locais, as: :localizavel, dependent: :destroy
  accepts_nested_attributes_for :locais, 
                                reject_if: proc { |attributes| attributes['logradouro'].blank? },
                                allow_destroy: true
  
  has_many :horarios, as: :funcionamento, dependent: :destroy
  accepts_nested_attributes_for :horarios, 
                                reject_if: proc { |attributes| attributes['dias'].blank? },
                                allow_destroy: true
  
  has_and_belongs_to_many :esportes
  has_and_belongs_to_many :eventos
  
  before_create :set_uuid
  
  def to_param
    uuid
  end
  
  has_attached_file :logo, 
                    :styles => { 
                      :small => "340x200>",
                      :original => "800x600>"
                    },
                    :path => "/lojas/:id/:basename_:style.:extension"

  validates_attachment :logo, 
    :size => { :in => 0..5.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png)$/ }
  
  def contato
    contato = telefone
    contato += " / " if contato.present?
    contato += email
    return contato
  end
  
  private
  
  def set_uuid
    self.uuid = SecureRandom.uuid
  end
  
end

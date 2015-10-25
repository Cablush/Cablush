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
  
  has_attached_file :logo, 
                    :styles => { 
                      :small => "340x200>",
                      :original => "800x600>"
                    },
                    :path => "/lojas/:id/:basename_:style.:extension"

  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/jpg', 'image/pjpeg', 'image/png', 'image/x-png']
  validates_attachment_file_name :logo, :matches => [/PNG\Z/, /png\Z/, /JPE?G\Z/, /jpe?g\Z/]
  validates_attachment :logo, :size => { :in => 0..5.megabytes }
  
  def contato
    contato = telefone
    contato += " / " if contato.present?
    contato += email
    return contato
  end
  
end

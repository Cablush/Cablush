class Evento < ActiveRecord::Base
  
  belongs_to :responsavel, class_name: "Usuario"
  
  has_one :local, as: :localizavel, dependent: :destroy
  accepts_nested_attributes_for :local, 
                                reject_if: proc { |attributes| attributes['logradouro'].blank? },
                                allow_destroy: true
                              
  has_and_belongs_to_many :esportes
  
  has_attached_file :flyer, 
                    :styles => { 
                      :small => "340x200>",
                      :original => "800x600>"
                    },
                    :path => "/eventos/:id/:basename_:style.:extension"

  validates_attachment_content_type :flyer, :content_type => ['image/jpeg', 'image/jpg', 'image/pjpeg', 'image/png', 'image/x-png']
  validates_attachment_file_name :flyer, :matches => [/PNG\Z/, /png\Z/, /JPE?G\Z/, /jpe?g\Z/]
  validates_attachment :flyer, :size => { :in => 0..5.megabytes }
  
  #  scope :public, -> { where(public: true) }
  #  scope :sponsored, -> { where(patrocinado: true) }
  
  def horario
    data + " " + hora
  end
  
end

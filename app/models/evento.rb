class Evento < ActiveRecord::Base
  
  belongs_to :responsavel, class_name: "Usuario"
  
  has_one :local, as: :localizavel
  has_and_belongs_to_many :esportes
  
  #has_attached_file :logo, :styles => { :small => "350x200>" , :big =>"750x500" },
  #  :url  => "/assets/eventos/:id/:style/:basename.:extension",
  #  :path => ":rails_root/public/assets/eventos/:id/:style/:basename.:extension"

  #validates_attachment_presence :logo
  #validates_attachment_size :logo, :less_than => 10.megabytes
  #validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png']
  
  #  scope :public, -> { where(public: true) }
  #  scope :sponsored, -> { where(patrocinado: true) }
  
end

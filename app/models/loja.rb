class Loja < ActiveRecord::Base
  
  belongs_to :responsavel, class_name: "Usuario"
  
  has_many :locais, as: :localizavel, dependent: :destroy
  accepts_nested_attributes_for :locais
  
  has_many :horarios, as: :funcionamento, dependent: :destroy
  accepts_nested_attributes_for :horarios
  
  has_and_belongs_to_many :esportes
  has_and_belongs_to_many :eventos
  
  #attr_accessible :nome, :logo, :horario, :descricao, :site, :contato, :email

  #has_attached_file :logo, :styles => { :small => "350x200>" },
  #                  :url  => "/assets/lojas/:id/:style/:basename.:extension",
  #                  :path => ":rails_root/public/assets/lojas/:id/:style/:basename.:extension"

  #validates_attachment_presence :logo
  #validates_attachment_size :logo, :less_than => 10.megabytes
  #validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png']
  #scope :esporte, lambda { |esp_id| where(esporte_id: esp_id) }
  
end

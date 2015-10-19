class Pista < ActiveRecord::Base
  
  belongs_to :responsavel, class_name: "Usuario"
  
  has_one :local, as: :localizavel, dependent: :destroy
  accepts_nested_attributes_for :local, 
                                reject_if: proc { |attributes| attributes['logradouro'].blank? },
                                allow_destroy: true
  
  has_many :horarios, as: :funcionamento, dependent: :destroy
  accepts_nested_attributes_for :horarios, 
                                reject_if: proc { |attributes| attributes['inicio'].blank? },
                                allow_destroy: true
  
  has_and_belongs_to_many :esportes
  
  #scope :esporte, lambda { |esp_id| where(esporte_id: esp_id) }

  #has_attached_file :logo, :styles => { :small => "350x200>" },
  #                  :url  => "/assets/pistas/:id/:style/:basename.:extension",
  #                  :path => ":rails_root/public/assets/pistas/:id/:style/:basename.:extension"

  #validates_attachment_presence :logo
  #validates_attachment_size :logo, :less_than => 10.megabytes
  #validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png']
  #scope :esporte, lambda { |esp_id| where(esporte_id: esp_id) }
    
end

class Pista < ActiveRecord::Base
  
  include Localizavel
  
  belongs_to :esporte
  

  #scope :esporte, lambda { |esp_id| where(esporte_id: esp_id) }


  has_attached_file :logo, :styles => { :small => "350x200>" },
                    :url  => "/assets/pistas/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/pistas/:id/:style/:basename.:extension"

  validates_attachment_presence :logo
  validates_attachment_size :logo, :less_than => 10.megabytes
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png']
  #scope :esporte, lambda { |esp_id| where(esporte_id: esp_id) }
    
end

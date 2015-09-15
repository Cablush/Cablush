class Pista < ActiveRecord::Base
  
  include Localizavel
  
  belongs_to :esporte
  
  #scope :esporte, lambda { |esp_id| where(esporte_id: esp_id) }
  
end

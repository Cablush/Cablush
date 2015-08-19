class Pista < ActiveRecord::Base
  belongs_to :esporte
  belongs_to :local
  belongs_to :usuario
  
  #scope :estado, lambda { |est_id| joins(:local).where(locals: {estado_id: est_id}) }
  #scope :esporte, lambda { |esp_id| where(esporte_id: esp_id) }
  
  # site: temporário até achar solução para não dar pau no home :P
  attr_accessor :site
  
  self.per_page = 9
  

  def self.esporte(search)
    if !search.nil? and search.length > 0
      where(esporte_id: search)
    else
      all
    end
  end

  def self.estado(search)
    if !search.nil? and search.length > 0
      joins(:local).where(locals: {estado_id: search}) 
    else
      all
    end
  end

end

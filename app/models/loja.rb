class Loja < ActiveRecord::Base
  
  #attr_accessible :nome, :logo, :horario, :descricao, :site, :contato, :email
  
  belongs_to :esporte
  belongs_to :local
  
  #scope :estado, lambda { |est_id| joins(:local).where(locals: {estado_id: est_id}) }
  #scope :esporte, lambda { |esp_id| where(esporte_id: esp_id) }
  
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

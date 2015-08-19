class Evento < ActiveRecord::Base
#  has_many :participantes :class_name =>'Usuario'
  belongs_to :usuario
  belongs_to :esporte
  belongs_to :local
  
  # site: temporário até achar solução para não dar pau no home :P
  attr_accessor :site

  
#  scope :public, -> { where(public: true) }
#  scope :sponsored, -> { where(patrocinado: true) }
# scope :estado, lambda { |est_id| joins(:estado).where(id: est_id) }
  
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

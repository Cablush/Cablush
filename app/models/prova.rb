class Prova < ActiveRecord::Base
  has_many :participantes
  belongs_to :etapa
end

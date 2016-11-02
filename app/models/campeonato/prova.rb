class Campeonato::Prova < ActiveRecord::Base
  has_many :provas_participantes
  has_many :participantes, through: :participantes
  belongs_to :etapa
end

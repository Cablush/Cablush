class Campeonato::Prova < ActiveRecord::Base
  belongs_to :etapa

  has_many :provas_participantes
  has_many :participantes, through: :participantes
end

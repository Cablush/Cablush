class Campeonato::ProvasParticipante < ActiveRecord::Base
  belongs_to :participantes
  belongs_to :provas
end

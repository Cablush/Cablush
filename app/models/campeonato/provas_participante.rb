class Campeonato::ProvasParticipante < ActiveRecord::Base
  belongs_to :participante
  belongs_to :prova

  scope :next, -> {
    where('pontuacao is null').order('prova_id ASC').first
  }
end

class Campeonato::Prova < ActiveRecord::Base
  belongs_to :etapa

  has_many :provas_participantes
  has_many :participantes, through: :participantes

  def allocate_participant(participante)
    Campeonato::ProvasParticipante.create(participante_id: participante.id,
                                         prova_id: id)
  end
end

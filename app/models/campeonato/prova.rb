class Campeonato::Prova < ActiveRecord::Base
  belongs_to :etapa

  has_many :provas_participantes
  has_many :participantes, through: :provas_participantes

  def num_participantes
    participantes.length
  end

  def allocate_participant(participante)
    Campeonato::ProvasParticipante.create(participante_id: participante.id,
                                          prova_id: id)
  end
end

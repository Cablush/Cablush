class Campeonato::Etapa < ActiveRecord::Base
  belongs_to :campeonato
  belongs_to :categoria

  has_many :provas, dependent: :destroy

  scope :find_by_categoria_id, ->(categoria_id) {
    eager_load(:provas).where('categoria_id = ?', categoria_id) if categoria_id.present?
  }

  scope :first_by_id, -> {
    order('id ASC').first
  }

  def num_provas
    provas.length
  end

  def self.generate_etapa(categoria, num_competidores)
    num_provas = Campeonato::Etapa.provas_por_etapa(num_competidores,
                                                    categoria.max_competidores_prova)
    etapa = create(nome: num_provas.to_s + ' avos',
                   categoria_id: categoria.id,
                   campeonato_id: categoria.campeonato_id)
    (1..num_provas).each do
      Campeonato::Prova.create(etapa_id: etapa.id)
    end
    etapa
  end

  def self.provas_por_etapa(num_competidores, max_competidores_prova)
    (num_competidores.to_f / max_competidores_prova.to_f).ceil
  end

  def allocate_participants(participantes)
    participantes = participantes_not_in_this_etapa(participantes)
    i = 0 # index to prova
    for j in 0..((participantes.length / 2.0).ceil - 1)
      if provas[i].num_participantes < categoria.max_competidores_prova
        # allocate first participant
        provas[i].allocate_participant(participantes[j])
        # allocate last participant, if exist
        k = participantes.length - 1 - j
        provas[i].allocate_participant(participantes[k]) if j < k
      end
      # change prova index
      i += 1
      i = 0 if i == provas.count
    end
  end

  private

  def participantes_not_in_this_etapa(participantes)
    etapa_participantes = Campeonato::Participante.in_etapa(id)
    participantes.select { |participante|
      etapa_participantes.include?(participante) == false
    }
  end
end

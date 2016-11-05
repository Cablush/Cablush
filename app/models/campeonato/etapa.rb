class Campeonato::Etapa < ActiveRecord::Base
  belongs_to :campeonato
  belongs_to :categoria

  has_many :provas, dependent: :destroy

  scope :find_by_categoria_id, ->(categoria_id) {
    eager_load(:provas).where('categoria_id = ?', categoria_id) if categoria_id.present?
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
end

class Cadastros::EtapasController < ApplicationController
  before_action :admin_only

  def new
    campeonato_uuid = params[:campeonato_uuid]
    campeonato = Campeonato.find_by_uuid(campeonato_uuid)
    num_max_participates = campeonato.max_competidores_categoria
    max_prova = campeonato.max_competidores_prova
    categorias = campeonato.categorias
    categorias.each do |categoria|
      while num_max_participates >= max_prova
        num_provas = provas_etapa(num_max_participates, max_prova)
        etapa = Campeonato::Etapa.create(nome: num_provas.to_s + ' avos',
                                         categoria_id: categoria.id,
                                         campeonato_id: campeonato.id)
        puts "Criar etapa com #{num_provas} provas e #{num_max_participates} participantes"
        (1..num_provas).each do
          prova = Campeonato::Prova.create(etapa_id: etapa.id)
          puts prova
        end
        num_max_participates = num_max_participates / campeonato.num_vencedores_prova
      end
    end
    distribui_participates_por_provas(campeonato.id)
    redirect_to cadastros_campeonatos_path
  end

  def distribui_participates_por_provas(campeonato_id)
    campeonato = Campeonato.find_by_id(campeonato_id)
    categorias = campeonato.categorias
    num_max_participates = campeonato.max_competidores_categoria
    categorias.each do |categoria|
      participantes = Campeonato::Participante.where(categoria_id: categoria.id)
      primeira_etapa = busca_primeira_etapa(categoria.etapas)
      provas = primeira_etapa.provas
      j = 0
      for i in 0..num_max_participates / 2
        Campeonato::ProvasParticipante.create(participante_id: participantes[i].id,
                                              prova_id: provas[j].id) # PRIMEIRO
        if participantes[num_max_participates - 1 - i].present?
          Campeonato::ProvasParticipante.create(participante_id: participantes[num_max_participates - 1 - i].id,
                                                prova_id: provas[j].id)#ULTIMO
        end
        if j == provas.count
          j = 0
        else
          j += 1
        end
      end
    end
  end

  def busca_primeira_etapa(etapas)
    array_max = []
    etapas.each do |etapa|
      array_max.append(etapa.provas.count)
    end
    index = array_max.index(array_max.max)
    etapas[index]
  end

  # Calcula o numero de participantes por etapa
  def participantes_etapa(provas_anteriores, vencedores_anteriores)
    provas_anteriores * vencedores_anteriores
  end

  # Calcula o numero de provar por etapa
  def provas_etapa(participantes, maximo_prova)
    (participantes.to_f / maximo_prova.to_f).ceil
  end

  # Calcula o numero de participantes por prova
  def participantes_provas(participantes, num_provas)
    part_provas = Array.new(num_provas, 0)
    pp_i = 0
    (1..participantes).each do
      pp_i = 0 if pp_i % num_provas == 0
      part_provas[pp_i] += 1
      pp_i += 1
    end
    part_provas
  end
end

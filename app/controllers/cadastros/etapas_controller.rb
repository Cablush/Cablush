class Cadastros::EtapasController < ApplicationController

  before_action :admin_only

  def new(campeonato_uuid)
    @campeonato = Campeonato.find_by_uuid(campeonato_uuid)
    numMaxParticipantes = @campeonato.max_competidores_categoria 
    max_prova = @campeonato.max_competidores_prova
    @categorias = Categoria.where(campeonato_id: campeonato_id)
    @categorias.each do |categoria|
      while numMaxParticipantes >= max_prova
       provas = provas_etapa(numMaxParticipantes, max_prova)
       etapa = Etapa.create(nome: ''+provas+'avos',categoria_id: categoria.id ,campeonato_id: campeonato_id)
       puts "Criar etapa com #{provas} provas e #{numMaxParticipantes} participantes"
       (1..provas).each do
          prova = Prova.create(etapa_id: etapa)
       end  
      end
    end
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
   return part_provas
  end
end
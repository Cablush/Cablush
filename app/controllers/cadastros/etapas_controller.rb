class Cadastros::EtapasController < ApplicationController

  before_action :admin_only

  def create(campeonato_id, categoria_id)
    @campeonato = Campeonato.find_by_id(campeonato_id)
    numMaxParticipantes = @campeonato.max_competidores_categoria 
    max_prova = @campeonato.max_competidores_prova
    while numMaxParticipantes >= max_prova
     provas = provas_etapa(numMaxParticipantes, max_prova)
     etapa = Etapa.create(nome: ''+provas+'avos', campeonato_id: campeonato_id)
     puts "Criar etapa com #{provas} provas e #{numMaxParticipantes} participantes"
     count_part_provas = 0
     part_provas = participantes_provas(numMaxParticipantes, provas)
     @participates = participates.where(categoria_id: categoria_id)
     @listParticipantes = [];
     part_provas.each_with_index do |part,index|
      prova = Prova.new(etapda_id: etapa.id)
      puts "Criar prova com #{part} participantes"
      @listParticipantes.push(participantes[index])
      participantes.delete_at(index)
     end
     prova.participantes = listParticipantes 
     puts prova
     participantes = participantes_etapa(provas, ven_prova)
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
-
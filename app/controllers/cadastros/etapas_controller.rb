class Cadastros::EtapasController < ApplicationController

  before_action :admin_only

  # POST /participantes(.:format)
  def create
    etapa = Etapa.new(participante_params)
    
    # TODO search by duplicated participantes before save
    if etapa.save
      render_json_success etapa, 200
    else
      render_json_error etapa.errors, 500
    end
  end

  def generateEtapas(campeonato_id)
    @campeonato = Campeonato.find_by_id(campeonato_id)
    participantes = @campeonato.max_competidores_categoria 
    max_prova = @campeonato.max_competidores_prova
    while participantes >= max_prova
     provas = provas_etapa(participantes, max_prova)
     etapa = Etapa.create(nome: ''+provas+'avos', campeonato_id: campeonato_id)
     puts "Criar etapa com #{provas} provas e #{participantes} participantes"
     count_part_provas = 0
     part_provas = participantes_provas(participantes, provas)
     part_provas.each do |part|
       puts "Criar prova com #{part} participantes"
       
     end
     puts " "
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

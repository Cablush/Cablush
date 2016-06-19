class Cadastros::ParticipantesController < ApplicationController

  before_action :authenticate_usuario!

	def index
    puts params

    @participantes = Participante.where(categoria_id: params[:campeonato])
		@title = I18n.t('views.cadastros.participante_title')
  	end

	def save_participante
    puts params
    participante = Participante.new(nome: params[:nome],numero_inscricao: params[:num_inscricao],
                                    categoria_id: params[:categoria], classificacao: params[:classificacao]) 
    if participante
      render status: 200, json: participante.to_json
    else
      render status: 500, json: participante.to_json
    end
  end

  # GET /campeonatos/:uuid(.:format)
  def participante_by_categoria
    @participante = Participante.find_by_categoria_id!(params[:categoria_id])
  end
	
  private

  def participante_params
    params.require(:participante)
          .permit(:nome, :num_inscricao, :classificacao, :categoria)
  end


end
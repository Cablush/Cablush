class Cadastros::ParticipantesController < ApplicationController

  before_action :authenticate_usuario!

	def index
    @campeonato_id = params[:campeonato_id]
    @title =  I18n.t('views.cadastros.participante_title', campeonato: params[:campeonato_nome]).html_safe

    @categorias = Categoria.where(campeonato_id: @campeonato_id)
    @participantes = Participante.find_by_categoria_id!(1)

    respond_to do |format|
      format.html
      format.json { render json: @participantes.to_json }
    end
  end

  def create
    participante = Participante.new(nome: params[:nome],numero_inscricao: params[:num_inscricao],
                                    categoria_id: params[:categoria], classificacao: params[:classificacao])
    if participante
      render status: 200, json: participante.to_json
    else
      render status: 500, json: participante.to_json
    end
  end

  def update

  end

  def destroy

  end

  private

  def participante_params
    params.require(:participante)
          .permit(:nome, :num_inscricao, :classificacao, :categoria)
  end


end

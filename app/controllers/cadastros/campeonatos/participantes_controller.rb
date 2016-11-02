class Cadastros::Campeonatos::ParticipantesController < ApplicationController
  before_action :admin_only

  # GET /participantes(.:format)
  def index
    @campeonato = Campeonato.find_by_uuid(params[:campeonato_uuid])

    if params[:categoria_id].present?
      @categorias = Array.new(1, Campeonato::Categoria.find_by_id(params[:categoria_id]))
    else
      @categorias = @campeonato.categorias
    end

    @title = I18n.t('views.cadastros.participante_title',
                    campeonato: @campeonato.nome).html_safe

    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /participantes(.:format)
  def create
    campeonato = Campeonato.find_by_uuid(params[:campeonato_uuid])

    participante = Campeonato::Participante.new(participante_params)
    participante.campeonato = campeonato

    if participante.save
      render_json_success participante, 200
    else
      render_json_error participante.errors, 500
    end
  end

  # GET /participantes/:uuid/edit(.:format)
  def edit
    @participante = Campeonato::Participante.find_by_uuid!(params[:uuid])

    respond_to do |format|
      format.js
      format.json { render json: @participante.to_json }
    end
  end

  # PATCH/PUT /participantes/:uuid(.:format)
  def update
    participante = Campeonato::Participante.find_by_uuid!(params[:uuid])

    if participante.update(participante_params)
      render_json_success participante, 200
    else
      render_json_error participante.errors, 500
    end
  end

  # DELETE /participantes/:uuid(.:format)
  def destroy
    participante = Campeonato::Participante.find_by_uuid!(params[:uuid])

    participante.destroy

    render_json_success participante, 200
  end

  private

  def participante_params
    params.require(:participante).permit(:uuid, :nome, :numero_inscricao,
                                         :classificacao, :categoria_id)
  end
end

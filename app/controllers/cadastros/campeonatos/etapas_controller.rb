class Cadastros::Campeonatos::EtapasController < Cadastros::CadastrosController
  # GET /etapas(.:format)
  def index
    @campeonato = find_campeonato_by_uuid(params[:campeonato_uuid])

    if params[:categoria_id].present?
      @etapas = Campeonato::Etapa.find_by_categoria_id(params[:categoria_id])
    else
      @etapas = Array.new(0)
      flash.now[:alert] = I18n.t 'views.cadastros.message_select_categoria'
    end

    @title = I18n.t('views.cadastros.etapas_title',
                    campeonato: @campeonato.nome).html_safe

    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /etapas(.:format)
  def create
    campeonato = find_campeonato_by_uuid(params[:campeonato_uuid])

    etapa = Campeonato::Etapa.new(etapa_params)
    etapa.campeonato = campeonato

    if etapa.save
      render_json_success etapa, 200
    else
      render_json_error etapa.errors, 500
    end
  end

  # GET /etapas/:uuid/edit(.:format)
  def edit
    @etapa = Campeonato::Etapa.find_by_uuid!(params[:uuid])

    respond_to do |format|
      format.js
      format.json { render json: @etapa.to_json }
    end
  end

  # PATCH/PUT /etapas/:uuid(.:format)
  def update
    etapa = Campeonato::Etapa.find_by_uuid!(params[:uuid])

    if etapa.update(etapa_params)
      render_json_success etapa, 200
    else
      render_json_error etapa.errors, 500
    end
  end

  # DELETE /etapas/:uuid(.:format)
  def destroy
    etapa = Campeonato::Etapa.find_by_uuid!(params[:uuid])

    etapa.destroy

    render_json_success etapa, 200
  end

  # POST /etapas/generate(.:format)
  def generate
    campeonato = find_campeonato_by_uuid(params[:campeonato_uuid])

    campeonato.generate_etapas

    render_json_success nil, 200, I18n.t('views.cadastros.gerar_etapas_success')
  rescue => ex
    logger.error ex.message
    render_json_error I18n.t('views.cadastros.gerar_etapas_error'), 500
  end

  private

  def etapa_params
    params.require(:etapa).permit(:nome, :campeonato_id, :categoria_id)
  end
end

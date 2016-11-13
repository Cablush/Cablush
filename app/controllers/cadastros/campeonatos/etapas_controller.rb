class Cadastros::Campeonatos::EtapasController < Cadastros::CadastrosController
  # GET /etapas(.:format)
  def index
    @campeonato = find_campeonato_by_uuid(params[:campeonato_uuid])

    if params[:categoria_id].present?
      @etapas = Campeonato::Etapa.find_by_categoria_id(params[:categoria_id])
    else
      @etapas = Array.new(0)
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
    begin
      campeonato = find_campeonato_by_uuid(params[:campeonato_uuid])

      campeonato.generate_etapas

      render_json_success nil, 200, I18n.t('views.cadastros.gerar_etapas_success')
    rescue => ex
      logger.error ex.message
      render_json_error I18n.t('views.cadastros.gerar_etapas_error'), 500
    end
  end

  private

  def etapa_params
    params.require(:etapa).permit(:nome, :campeonato_id, :categoria_id)
  end

  def distribui_participates_por_provas(campeonato_id)
    campeonato = find_campeonato_by_uuid(campeonato_id)
    categorias = campeonato.categorias
    max_categoria = campeonato.max_competidores_categoria
    categorias.each do |categoria|
      participantes = Campeonato::Participante.where(categoria_id: categoria.id)
      primeira_etapa = busca_primeira_etapa(categoria.etapas)
      provas = primeira_etapa.provas
      j = 0
      for i in 0..max_categoria / 2
        Campeonato::ProvasParticipante.create(participante_id: participantes[i].id,
                                              prova_id: provas[j].id) # PRIMEIRO
        if participantes[max_categoria - 1 - i].present?
          Campeonato::ProvasParticipante.create(participante_id: participantes[max_categoria - 1 - i].id,
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
end

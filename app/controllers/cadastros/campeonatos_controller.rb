class Cadastros::CampeonatosController < Cadastros::CadastrosController
  include EsportesUpdate

  before_action :admin_only # TODO change to

  # GET /campeonatos(.:format)
  def index
    if current_usuario.admin?
      @campeonatos = Campeonato.all.order('data_inicio DESC')
    else
      @campeonatos = current_usuario.campeonatos.order('data_inicio DESC')
    end
    @title = I18n.t('views.cadastros.campeonatos_title',
                    length: @campeonatos.length.to_s)
  end

  # GET /campeonatos/new(.:format)
  def new
    @campeonato = Campeonato.new
    @campeonato.build_local

    @title = I18n.t 'views.cadastros.novo_campeonato_title'
  end

  # POST /campeonatos(.:format)
  def create
    update_esporte_ids(params[:campeonato])

    @campeonato = current_usuario.campeonatos.build(campeonato_params)
    if @campeonato.save
      redirect_to cadastros_campeonatos_path
    else
      render 'new'
    end
  end

  # GET /campeonatos/:uuid/edit(.:format)
  def edit
    @campeonato = find_campeonato_by_uuid(param[:uuid])

    if @campeonato.local.blank?
      @campeonato.build_local
    end

    @title = I18n.t('views.cadastros.editar_campeonato_title',
                    campeonato: @campeonato.nome).html_safe
  end

  # PATCH/PUT /campeonatos/:uuid(.:format)
  def update
    @campeonato = find_campeonato_by_uuid(param[:uuid])

    update_esporte_ids(params[:campeonato])

    if @campeonato.update(campeonato_params)
      redirect_to cadastros_campeonatos_path
    else
      render 'edit'
    end
  end

  # DELETE /campeonatos/:uuid(.:format)
  def destroy
    @campeonato = find_campeonato_by_uuid(param[:uuid])

    @campeonato.destroy
    redirect_to cadastros_campeonatos_path
  end

  # POST /campeonatos/:uuid/evento(.:format)
  def evento
    campeonato = find_campeonato_by_uuid(param[:uuid])

    if campeonato.evento.present?
      render_json_error(I18n.t('views.cadastros.event_already_exists'),
                        200) and return
    end

    local = campeonato.local.dup
    esporte_ids = campeonato.esportes.map{ |esporte| esporte.id }

    evento = Evento.new(nome: campeonato.nome,
                        descricao: campeonato.descricao,
                        data: campeonato.data_inicio,
                        hora: campeonato.hora,
                        data_fim: campeonato.data_fim,
                        flyer: campeonato.flyer,
                        local: local,
                        esporte_ids: esporte_ids,
                        responsavel: current_usuario,
                        campeonato: campeonato)

    if evento.save
      render_json_success(evento, 200, I18n.t('message.save_success',
                                              model: Evento.model_name.human))
    else
      render_json_error(I18n.t('message.save_error',
                               model: Evento.model_name.human), 500)
    end
  end

  private

  def campeonato_params
    params.require(:campeonato)
          .permit(:nome, :descricao, :data_inicio, :hora, :data_fim,
                  :max_competidores_categoria, :min_competidores_categoria,
                  :max_competidores_prova, :min_competidores_prova,
                  :num_vencedores_prova, :flyer, :fundo,
                  categorias_attributes: [:id, :uuid, :nome, :descricao,
                                          :regras, :_destroy],
                  esporte_ids: [],
                  local_attributes: [:id, :latitude, :longitude, :logradouro,
                                     :numero, :complemento, :bairro, :cidade,
                                     :estado, :estado_nome, :cep, :pais])
  end
end

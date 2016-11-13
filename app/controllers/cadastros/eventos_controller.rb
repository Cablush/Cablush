class Cadastros::EventosController < Cadastros::CadastrosController
  include EsportesUpdate

  # GET /eventos(.:format)
  def index
    if current_usuario.admin?
      @eventos = Evento.all.order('data DESC')
    else
      @eventos = current_usuario.eventos.order('data DESC')
    end
    @title = I18n.t('views.cadastros.eventos_title',
                    length: @eventos.length.to_s)
  end

  # GET /eventos/new(.:format)
  def new
    @evento = Evento.new
    @evento.build_local

    @title = I18n.t 'views.cadastros.novo_evento_title'
  end

  # POST /eventos(.:format)
  def create
    update_esporte_ids(params[:evento])

    @evento = current_usuario.eventos.build(evento_params)

    if @evento.save
      redirect_to evento_path(@evento)
    else
      render 'new'
    end
  end

  # GET /eventos/:uuid/edit(.:format)
  def edit
    @evento = find_evento_by_uuid

    if @evento.local.blank?
      @evento.build_local
    end

    @title = I18n.t('views.cadastros.editar_evento_title',
                    evento: @evento.nome).html_safe
  end

  # PATCH/PUT /eventos/:uuid(.:format)
  def update
    @evento = find_evento_by_uuid

    update_esporte_ids(params[:evento])

    if @evento.update(evento_params)
      redirect_to evento_path(@evento)
    else
      render 'edit'
    end
  end

  # DELETE /eventos/:uuid(.:format)
  def destroy
    @evento = find_evento_by_uuid

    @evento.destroy

    redirect_to cadastros_eventos_path
  end

  private

  def find_evento_by_uuid
    if current_usuario.admin?
      Evento.find_by_uuid!(params[:uuid])
    else
      current_usuario.eventos.find_by_uuid!(params[:uuid])
    end
  end

  def evento_params
    params.require(:evento)
          .permit(:nome, :descricao, :data, :hora, :data_fim, :website,
                  :facebook, :flyer, :fundo,
                  esporte_ids: [],
                  local_attributes: [:id, :latitude, :longitude, :logradouro,
                                     :numero, :complemento, :bairro, :cidade,
                                     :estado, :estado_nome, :cep, :pais])
  end
end

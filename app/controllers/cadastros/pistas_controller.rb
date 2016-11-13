class Cadastros::PistasController < Cadastros::CadastrosController
  include EsportesUpdate

  # GET /pistas(.:format)
  def index
    if current_usuario.admin?
      @pistas = Pista.all
    else
      @pistas = current_usuario.pistas
    end
    @title = I18n.t('views.cadastros.pistas_title',
                    length: @pistas.length.to_s)
  end

  # GET /pistas/new(.:format)
  def new
    @pista = Pista.new
    @pista.build_local
    @pista.build_horario

    @title = I18n.t 'views.cadastros.nova_pista_title'
  end

  # POST /pistas(.:format)
  def create
    update_esporte_ids(params[:loja])

    @pista = current_usuario.pistas.build(pista_params)

    if @pista.save
      redirect_to pista_path(@pista)
    else
      render 'new'
    end
  end

  # GET /pistas/:uuid/edit(.:format)
  def edit
    @pista = find_pista_by_uuid

    if @pista.local.blank?
      @pista.build_local
    end
    if @pista.horario.blank?
      @pista.build_horario
    end

    @title = I18n.t('views.cadastros.editar_pista_title',
                    pista: @pista.nome).html_safe
  end

  # PATCH/PUT /pistas/:uuid(.:format)
  def update
    @pista = find_pista_by_uuid

    update_esporte_ids(params[:loja])

    if @pista.update(pista_params)
      redirect_to pista_path(@pista)
    else
      render 'edit'
    end
  end

  # DELETE /pistas/:uuid(.:format)
  def destroy
    @pista = find_pista_by_uuid

    @pista.destroy

    redirect_to cadastros_pistas_path
  end

  private

  def find_pista_by_uuid
    if current_usuario.admin?
      Pista.find_by_uuid!(params[:uuid])
    else
      current_usuario.pistas.find_by_uuid!(params[:uuid])
    end
  end

  def pista_params
    params.require(:pista)
          .permit(:nome, :descricao, :website, :facebook, :foto, :video,
                  esporte_ids: [],
                  local_attributes: [:id, :latitude, :longitude, :logradouro,
                                     :numero, :complemento, :bairro, :cidade,
                                     :estado, :estado_nome, :cep, :pais],
                  horario_attributes: [:id, :seg, :ter, :qua, :qui, :sex, :sab,
                                       :dom, :inicio, :fim, :detalhes])
  end
end

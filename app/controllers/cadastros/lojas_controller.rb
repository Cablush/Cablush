class Cadastros::LojasController < ApplicationController
  include EsportesUpdate

  before_action :authenticate_usuario!

  # GET /lojas(.:format)
  def index
    if current_usuario.admin?
      @lojas = Loja.all
    else
      @lojas = current_usuario.lojas
    end
    @title = I18n.t('views.cadastros.lojas_title', length: @lojas.length.to_s)
  end

  # GET /lojas/new(.:format)
  def new
    @loja = Loja.new
    @loja.locais.build
    @loja.build_horario

    @title = I18n.t 'views.cadastros.nova_loja_title'
  end

  # POST /lojas(.:format)
  def create
    update_esporte_ids(params[:loja])

    @loja = current_usuario.lojas.build(loja_params)

    if @loja.save
      redirect_to loja_path(@loja)
    else
      render 'new'
    end
  end

  # GET /lojas/:uuid/edit(.:format)
  def edit
    @loja = find_loja_by_uuid

    if @loja.locais.empty?
      @loja.locais.build
    end
    if @loja.horario.blank?
      @loja.build_horario
    end

    @title = I18n.t('views.cadastros.editar_loja_title',
                    loja: @loja.nome).html_safe
  end

  # PATCH/PUT /lojas/:uuid(.:format)
  def update
    @loja = find_loja_by_uuid

    update_esporte_ids(params[:loja])

    if @loja.update(loja_params)
      redirect_to loja_path(@loja)
    else
      render 'edit'
    end
  end

  # DELETE /lojas/:uuid(.:format)
  def destroy
    @loja = find_loja_by_uuid

    @loja.destroy

    redirect_to cadastros_lojas_path
  end

  private

  def find_loja_by_uuid
    if current_usuario.admin?
      Loja.find_by_uuid!(params[:uuid])
    else
      current_usuario.lojas.find_by_uuid!(params[:uuid])
    end
  end

  def loja_params
    params.require(:loja)
          .permit(:nome, :telefone, :email, :website, :facebook, :logo, :fundo,
                  :descricao,
                  esporte_ids: [],
                  locais_attributes: [:id, :latitude, :longitude, :logradouro,
                                      :numero, :complemento, :bairro, :cidade,
                                      :estado, :estado_nome, :cep, :pais],
                  horario_attributes: [:id, :seg, :ter, :qua, :qui, :sex, :sab,
                                       :dom, :inicio, :fim, :detalhes])
  end
end

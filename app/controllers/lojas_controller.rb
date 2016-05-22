class LojasController < ApplicationController

  impressionist actions: [:index]

  # GET /lojas(.:format)
  def index

    load_lojas

    @title = "Encontre a loja mais próxima de você!"

    if @locais.empty?
      flash.now[:alert] = 'Nenhuma loja encontrada! Cadastre-se no Cablush e divulge as lojas da sua cidade!'
    end

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @locais.to_json }
    end
  end

  # GET /lojas/:uuid(.:format)
  def show

    unless request.xhr?
      load_lojas
    end

    @loja = Loja.find_by_uuid!(params[:uuid])

    impressionist(@loja)

    @title = @loja.nome

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @loja.to_json }
    end
  end

  private

  def load_lojas
    @locais = Local.lojas.paginate(:page => params[:page], :per_page => 9)
    @locais = @locais.lojas_by_estado(params[:estado]) if params[:estado].present?
    @locais = @locais.lojas_by_esporte_categoria(params[:esporte]) if params[:esporte].present?

    @clear = params[:filter] && params[:page].blank? || nil
  end

end

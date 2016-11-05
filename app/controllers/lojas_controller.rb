class LojasController < ApplicationController
  impressionist actions: [:index]

  # GET /lojas(.:format)
  def index
    load_lojas

    @title = I18n.t 'views.lojas.title'

    flash.now[:alert] = I18n.t 'views.lojas.not_found' if @locais.empty?

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @locais.to_json }
    end
  end

  # GET /lojas/:uuid(.:format)
  def show
    load_lojas unless request.xhr?

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
    @locais = Local.lojas.paginate(page: params[:page], per_page: 9)
    @locais = @locais.lojas_by_estado(params[:estado]) if params[:estado].present?
    @locais = @locais.lojas_by_esporte_categoria(params[:esporte]) if params[:esporte].present?

    @clear = params[:filter] && params[:page].blank? || nil
  end
end

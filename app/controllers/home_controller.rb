class HomeController < ApplicationController
  before_action :authenticate_usuario!, only: [:cadastros]

  def index
    @title = I18n.t 'views.index.title'

    @locais = Local.localizaveis_active

    flash.now[:alert] = I18n.t 'views.index.not_found' if @locais.empty?

    respond_to do |format|
      format.html { @locais }
      format.js { @locais }
      format.json { render json: @locais.to_json }
    end
  end

  def about
    @title = I18n.t 'views.about.title'
  end

  def cadastros
    if current_usuario.admin?
      @title = I18n.t('views.cadastros.title_admin').html_safe
    elsif current_usuario.lojista?
      @title = I18n.t('views.cadastros.title_lojista').html_safe
      if current_usuario.lojas.blank?
        flash.now[:alert] = I18n.t('views.cadastros.alert_lojista').html_safe
      end
    else
      @title = I18n.t('views.cadastros.title_esportista',
                      usuario: current_usuario.first_name).html_safe
    end
  end
end

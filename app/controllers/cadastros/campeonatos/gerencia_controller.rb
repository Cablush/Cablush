class Cadastros::Campeonatos::GerenciaController < Cadastros::CadastrosController
  # GET /participantes(.:format)
  def index
    @campeonato = find_campeonato_by_uuid(params[:campeonato_uuid])

    if params[:categoria_id].present?
      @categorias = Array.new(1, Campeonato::Categoria.find_by_id(params[:categoria_id]))
    else
      @categorias = @campeonato.categorias
    end

    @title = I18n.t('views.cadastros.gerencia_title',
                    campeonato: @campeonato.nome).html_safe
  end
end

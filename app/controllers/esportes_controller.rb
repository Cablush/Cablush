class EsportesController < ApplicationController
  def autocomplete_esporte_nome
    esportes = Esporte.find_like_nome_or_categoria(params[:term])
    render json: esportes.map { |esporte| {
      id: esporte.id,
      label: esporte.categoria_esporte,
      value: esporte.categoria_esporte }
    }
  end
end

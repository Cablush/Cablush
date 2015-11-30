require 'active_support/concern'

module EsporteAutocompletes
  extend ActiveSupport::Concern
  
  def autocomplete_esporte_nome
    esportes = Esporte.find_like_nome_or_categoria(params[:term])
    render :json => esportes.map { |esporte| {:id => esporte.id, 
                                              :label => esporte.categoria_esporte, 
                                              :value => esporte.categoria_esporte} }
  end
  
  def update_esporte_ids(host_params)
    if params[:esportes_attibutes].present?
      params[:esportes_attibutes].each do |index, esporte_params|
        if esporte_params[:id].blank? && esporte_params[:nome].present?
          esporte = Esporte.save?(esporte_params[:nome], Esporte.categoria['outros'])
          if esporte != nil
            host_params.merge({:esporte_ids => (host_params[:esporte_ids].push(esporte.id.to_s))})
          end
        end
      end
    end
  end
  
end

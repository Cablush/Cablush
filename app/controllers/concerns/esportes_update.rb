require 'active_support/concern'

module EsportesUpdate extend ActiveSupport::Concern
  # Updates the list of sports, saving the new sports in the category 'outros'
  # This method also updates the list of sports_ids in the host_params attribute
  def update_esporte_ids(host_params)
    if params[:esportes_attributes].present?
      params[:esportes_attributes].each do |index, esporte_params|
        if esporte_params[:nome].present? && esporte_params[:id].blank?
          esporte = Esporte.save?(esporte_params[:nome],
                                  Esporte.categorias['outros'])
          unless esporte.nil?
            host_params.merge(
              esporte_ids: host_params[:esporte_ids].push(esporte.id.to_s)
            )
          end
        end
      end
    end
  end
end

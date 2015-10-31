require 'active_support/concern'

module LocalAutocompletes 
  extend ActiveSupport::Concern
  
  def autocomplete_cidade_nome
    cidades = Cidade.find_like_nome(params[:term]).from_estado(params[:estado])
    render :json => cidades.map { |cidade| {:id => cidade.id, 
                                            :label => cidade.cidade_estado, 
                                            :value => cidade.nome, 
                                            :estado => cidade.estado.rg} }
  end
  
end

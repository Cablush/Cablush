class Api::PistasController < ApplicationController
	def index
		puts params[:nome]
      nome 	= params[:nome] || ""
	  estado  = params[:estado] || ""
	  esporte = params[:esporte] || ""
	  unless nome.nil? || nome.empty?
      	@pistas = Pista.all
      else
      	@pistas = Pista.find_by_nome(nome) || []
      end
      respond_to do |format|
  			format.json { render json: @pistas }
	  end
  	end
end


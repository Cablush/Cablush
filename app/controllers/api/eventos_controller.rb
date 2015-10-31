class Api::EventosController < ApplicationController
	def index
		nome 	= params[:nome]
		estado  = params[:estado]
		esporte = params[:esporte]
        @eventos = Evento.all
        respond_to do |format|
  			format.json { render json: @eventos }
		end
  	end
end

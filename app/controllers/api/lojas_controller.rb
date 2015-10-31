class Api::LojasController < ApplicationController
	def index
		nome 	= params[:nome]
		estado  = params[:estado]
		esporte = params[:esporte]
        @lojas = Loja.all
        respond_to do |format|
  			format.json { render json: @lojas }
		end
  	end
end

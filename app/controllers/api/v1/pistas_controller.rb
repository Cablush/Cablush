module Api
	module V1
    	class PistasController < ActionController::Base
			def index
		      @pistas = Pista.all
		  	end

		  	def endereco
		  		@pistas = Pista.endereco
		  	end
		end
  	end
end
class Api::PistasController < Api::ApiController
  
  # GET /pistas
  def index
    @pistas = Pista.find_like_name(pista_params['nome'])
    @pistas = @pistas.find_by_estado(pista_params['estado'])
    @pistas = @pistas.find_by_esporte_id(pista_params['esporte'])
    
    respond_to do |format|
      format.json { render json: @pistas, 
        :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
        :include => { :local => {:except => [:id, :created_at, :updated_at, :localizavel_id]}}
      }
    end
  end

   # GET /pistas/new(.:format)
  def new
    @pista = Pista.new
    @pista.build_local
    @pista.build_horario
  end

  # POST /pistas(.:format)
  def create
    @usuario = Usuario.find_by_uid(pista_params['uid'])
    @pista = @usuario.pistas.build(pista_params['pista'])
        
    if @pista.save
      respond_to do |format|
        format.json { render json: @pistas, 
        :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
        :include => { :local => {:except => [:id, :created_at, :updated_at, :localizavel_id]}}
      }
      end
    else
      render 'new'
    end
  end

  private
  
  def pista_params
    params.permit(:nome, :estado, :esporte)
  end
end


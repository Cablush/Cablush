class Api::LojasController < Api::ApiController
	before_action :authenticate_usuario!
  # GET /lojas
  def index
    @lojas = Loja.find_like_name(loja_params['nome'])
    @lojas = @lojas.find_by_estado(loja_params['estado'])
    @lojas = @lojas.find_by_esporte_id(loja_params['esporte'])
    
    respond_to do |format|
      format.json { render json: @lojas, 
        :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
        :include => { :locais => {:except => [:id, :created_at, :updated_at, :localizavel_id]}}
      }
		end
  end
  
   # GET /lojas/new(.:format)
  def new
    @loja = Loja.new
    @loja.locais.build
    @loja.build_horario
  end

  # POST /lojas(.:format)
  def create
    @loja = Loja.new
    @loja.nome = loja_params['nome']
    @loja.estado = loja_params['estado']
    @loja.esporte = loja_params['esporte']
    @loja.descricao = loja_params['descricao']
    @loja.telefone = loja_params['telefone']
    @loja.email = loja_params['email']
    @loja.facebook = loja_params['facebook']
    @loja.website = loja_params['website']
    @loja.fundo = loja_params['fundo']
    @loja.uuid = loja_params['uuid']
    
    @loja = current_usuario.lojas.build(loja_params['loja'])
        
    if @loja.save
      respond_to do |format|
        format.json { render json: @loja, 
        :except => [:id, :created_at, :updated_at, :responsavel_id, :logo_updated_at],
        :include => { :local => {:except => [:id, :created_at, :updated_at, :localizavel_id]}}
      }
      end
    else
      render 'new'
    end
  end

  private
  
  def loja_params
    params.permit(:nome, :estado, :esporte, :descricao,:telefone, :email, :facebook, :website, :fundo, :uuid)
  end
  
end

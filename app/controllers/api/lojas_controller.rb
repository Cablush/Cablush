class Api::LojasController < Api::ApiController
  
  before_action :authenticate_usuario!, only: [:mine, :create, :update, :upload]
  
  # GET /lojas
  def index
    lojas = Loja.find_like_name(params['nome'])
    lojas = lojas.find_by_estado(params['estado'])
    lojas = lojas.find_by_esporte_categoria(params['esporte'])
    
    render_lojas lojas
  end
  
  # GET /lojas/mine
  def mine
    lojas = Loja.where(responsavel_id: current_usuario.id)
    
    render_lojas lojas
  end
  
  # POST /lojas(.:format)
  def create
    loja = build_loja
    loja.responsavel = current_usuario
    
    if loja.save
      render_success loja
    else
      render_error loja
    end
  end
  
  # PATCH/PUT /lojas/:uuid
  def update
    loja = Loja.find_by_uuid_and_responsavel_id(params[:uuid], current_usuario.id)
    loja = build_loja(loja)
    
    if loja.save 
      render_success loja
    else
      render_error loja
    end
  end
  
  # POST /lojas/:uuid/upload
  def upload
    loja = Loja.find_by_uuid_and_responsavel_id(params[:uuid], current_usuario.id)
    
    if loja.update(params[:logo])
      render_success loja
    else
      render_error loja
    end
  end

  private
  
  def build_loja(*loja)
    # get the permitted parameters
    loja_attributes = params.permit(:nome, :descricao, :telefone, :email, :website, :facebook, :responsavel_uuid, :uuid,
        esportes: [:id],
        horario: [:inicio, :fim, :seg, :ter, :qua, :qui, :sex, :sab, :dom, :detalhes],
        locais: [:latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :cep, :pais]
      )
    
    # extract nested objects
    responsavel_uuid = loja_attributes.delete("responsavel_uuid")
    esporte_attributes = loja_attributes.delete("esportes")
    horario_attributes = loja_attributes.delete("horario")
    locais_attributes = loja_attributes.delete("locais")
    
    # create a new object or update if it exists
    if (loja.nil?)
      loja = Loja.new(loja_attributes)
    else
      loja.assign_attributes(loja_attributes)
    end
    loja.esporte_ids = esporte_attributes.map{|e| e["id"]}
    loja.horario = Horario.new(horario_attributes)
    loja.locais = locais_attributes.map{|l| Local.new(l)}
    return loja
  end
  
  def render_lojas(lojas)
    render json: lojas
  end
  
  def render_success(loja)
    render json: {
        success: true,
        data: loja
      }
  end
  
  def render_error(loja)
    render json: {
        success: false,
        errors: loja.errors
      }, status: 500
  end
  
end

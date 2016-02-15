class Api::LojasController < Api::ApiController
  
  before_action :authenticate_usuario!, only: [:mine, :create, :update]
  
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
    if current_usuario.admin?
      loja = Loja.find_by_uuid!(params[:uuid])
    else
      loja = current_usuario.lojas.find_by_uuid!(params[:uuid])
    end
    
    if loja.update(build_loja)
      render_success loja
    else
      render_error loja
    end
  end

  private
  
  def build_loja
    # get the permitted parameters
    loja_attributes = params.permit(:uuid, :nome, :telefone, :email, :website, :facebook, :logo, :fundo, :descricao, :updated_at,
        esportes: [:id],
        horario: [:seg, :ter, :qua, :qui, :sex, :sab, :dom, :inicio, :fim, :detalhes],
        locais: [:latitude, :longitude, :logradouro, :numero, :complemento, :bairro, :cidade, :estado, :cep, :pais]
      )
    
    # extract nested objects
    esporte_attributes = loja_attributes.delete("esportes")
    horario_attributes = loja_attributes.delete("horario")
    locais_attributes = loja_attributes.delete("locais")
    
    # create the object
    loja = Loja.new(loja_attributes)
    loja.esporte_ids = esporte_attributes.map{|e| e["id"]}
    loja.horario = Horario.new(horario_attributes)
    loja.locais = locais_attributes.map{|l| Local.new(l)}
    return loja
  end
  
  def render_lojas(lojas)
    render json: lojas, 
      :except => [:id, :created_at, :responsavel_id, :logo_file_name, :logo_content_type, :logo_file_size, :logo_updated_at],
      :methods => [:logo_url, :responsavel_uuid],
      :include => {
        :locais => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
        :esportes => {:except => [:created_at, :updated_at]},
        :horario => {:except => [:id, :created_at, :updated_at, :funcionamento_id, :funcionamento_type]}
      }
  end
  
  def render_success(loja)
    render json: {
        success: true,
        data: loja, 
          :except => [:id, :created_at, :responsavel_id, :logo_file_name, :logo_content_type, :logo_file_size, :logo_updated_at],
          :methods => [:logo_url, :responsavel_uuid],
          :include => {
            :locais => {:except => [:id, :created_at, :updated_at, :localizavel_id, :localizavel_type]},
            :esportes => {:except => [:created_at, :updated_at]},
            :horario => {:except => [:id, :created_at, :updated_at, :funcionamento_id, :funcionamento_type]}
          }
      }
  end
  
  def render_error(loja)
    render json: {
        success: false,
        errors: loja.errors
      }, status: 500
  end
  
end

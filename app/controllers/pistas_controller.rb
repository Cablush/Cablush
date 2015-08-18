class PistasController < ApplicationController
  
  before_action :authenticate_usuario!
  before_action :lojista_at_least, :except => :show

  # GET /pistas(.:format)
  def index
    if current_usuario.admin?
      @pistas = Pista.all
    else
      @pistas = current_usuario.pistas
    end
  end
  
  # GET /pistas/new(.:format)
  def new
    @pista = Pista.new
  end

  # POST /pistas(.:format)
  def create
    if current_usuario.admin?
      @pista = Pista.new(loja_params)
    else
      @pista = current_usuario.pistas.build(loja_params)
    end
    
    if @pista.save
      redirect_to lojas_path
    else
      render 'new'
    end
  end
  
  # GET /pistas/:id(.:format)
  def show
    @pista = Pista.find(params[:id])
  end

  # GET /pistas/:id/edit(.:format)
  def edit
    if current_usuario.admin?
      @pista = Pista.find(params[:id])
    else
      @pista = current_usuario.pistas.find(params[:id])
    end
  end

  # PATCH/PUT /pistas/:id(.:format)
  def update
    if current_usuario.admin?
      @pista = Pista.find(params[:id])
    else
      @pista = current_usuario.pistas.find(params[:id])
    end

    if @pista.update(loja_params)
      redirect_to lojas_path
    else
      render 'edit'
    end
  end
  
  # DELETE /pistas/:id(.:format)
  def destroy
    if current_usuario.admin?
      @pista = Pista.find(params[:id])
    else
      @pista = current_usuario.pistas.find(params[:id])
    end
    
    @pista.destroy

    redirect_to lojas_path
  end
  
  private
  
  def pista_params
    params.require(:pista).permit(:nome, :facebook, :email, :contato, :site, :logo, :descricao, :fundo)
  end
  
end

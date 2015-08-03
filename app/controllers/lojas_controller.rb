class LojasController < ApplicationController
  
  before_action :authenticate_usuario!
  before_action :lojista_at_least, :except => :show

  # GET /lojas(.:format)
  def index
    if current_usuario.admin?
      @lojas = Loja.all
    else
      @lojas = current_usuario.lojas
    end
  end
  
  # GET /lojas/new(.:format)
  def new
    @loja = Loja.new
  end

  # POST /lojas(.:format)
  def create
    if current_usuario.admin?
      @loja = Loja.new(loja_params)
    else
      @loja = current_usuario.lojas.build(loja_params)
    end
    
    if @loja.save
      redirect_to lojas_path
    else
      render 'new'
    end
  end
  
  # GET /lojas/:id(.:format)
  def show
    @loja = Loja.find(params[:id])
  end

  # GET /lojas/:id/edit(.:format)
  def edit
    if current_usuario.admin?
      @loja = Loja.find(params[:id])
    else
      @loja = current_usuario.lojas.find(params[:id])
    end
  end

  # PATCH/PUT /lojas/:id(.:format)
  def update
    if current_usuario.admin?
      @loja = Loja.find(params[:id])
    else
      @loja = current_usuario.lojas.find(params[:id])
    end

    if @loja.update(loja_params)
      redirect_to lojas_path
    else
      render 'edit'
    end
  end
  
  # DELETE /lojas/:id(.:format)
  def destroy
    if current_usuario.admin?
      @loja = Loja.find(params[:id])
    else
      @loja = current_usuario.lojas.find(params[:id])
    end
    
    @loja.destroy

    redirect_to lojas_path
  end
  
  private
  
  def loja_params
    params.require(:loja).permit(:nome, :facebook, :email, :contato, :site, :logo, :descricao, :fundo)
  end
  
end

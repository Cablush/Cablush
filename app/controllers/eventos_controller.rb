class EventosController < ApplicationController
  
  before_action :authenticate_usuario!
  before_action :lojista_at_least, :except => :show
  
  # GET /eventos(.:format)
  def index
    if current_usuario.admin?
      @eventos = Evento.all
    else
      @eventos = current_usuario.eventos
    end
  end
  
  # GET /eventos/new(.:format)
  def new
    @evento = Evento.new
  end

  # POST /eventos(.:format)
  def create
    if current_usuario.admin?
      @evento = Evento.new(evento_params)
    else
      @evento = current_usuario.eventos.build(evento_params)
    end
    
    if @evento.save
      redirect_to eventos_path
    else
      render 'new'
    end
  end
  
  # GET /eventos/:id(.:format)
  def show
    @evento = Evento.find(params[:id])
  end

  # GET /eventos/:id/edit(.:format)
  def edit
    if current_usuario.admin?
      @evento = Evento.find(params[:id])
    else
      @evento = current_usuario.eventos.find(params[:id])
    end
  end

  # PATCH/PUT /eventos/:id(.:format)
  def update
    if current_usuario.admin?
      @evento = Evento.find(params[:id])
    else
      @evento = current_usuario.eventos.find(params[:id])
    end

    if @evento.update(evento_params)
      redirect_to eventos_path
    else
      render 'edit'
    end
  end
  
  # DELETE /eventos/:id(.:format)
  def destroy
    if current_usuario.admin?
      @evento = Evento.find(params[:id])
    else
      @evento = current_usuario.eventos.find(params[:id])
    end
    
    @evento.destroy

    redirect_to eventos_path
  end
  
  private
  
  def evento_params
    params.require(:evento).permit(:nome, :facebook, :contato, :logo, :descricao, :fundo)
  end

end
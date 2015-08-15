class EventosController < ApplicationController
  
  before_action :authenticate_usuario!
  before_action :lojista_at_least, :except => :show
  
  # GET /lojas(.:format)
  def index
    if current_usuario.admin?
      @eventos = Evento.all
    else
      @eventos = current_usuario.eventos
    end
  end
  
  def new
    @evento = Evento.new
    
    respond_to do |format|
      format.html
      format.json { render json: @evento }
    end
  end

  def create
    @evento = Evento.new(params[:evento])

    respond_to do |format|
      if @evento.save
        format.html { redirect_to evento_new_path, notice: 'Evento was successfully created.' }
        format.json { render json: @evento }
      else
        format.html { render action: "new" }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @evento = Evento.find(params[:id])
    @evento.destroy

    respond_to do |format|
      format.html { render action: "edit" }
      format.json { head :no_content }
    end
  end
  
  def edit
    @evento = Evento.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render json: @evento }
    end
  end

  def update
    @evento = Evento.find(params[:id])

    respond_to do |format|
      if @evento.update_attributes(params[:evento])
        format.html { redirect_to evento_edit_path, notice: 'Evento was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end
  
end

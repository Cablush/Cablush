class HomeController < ApplicationController
 
  def lojas
    @lojas = Loja.includes(:local).estado(params[:estado]).esporte(params[:esporte]).paginate(:page => params[:page]).order(:created_at)
    
    @filter = params[:filter] || nil
    @title = "Em qualquer estado sempre com as lojas proximo de você!"
    respond_to do |format|
       format.html { @lojas}
       format.js { @lojas }
       format.json { render :json => @lojas.to_json(:include => :local) }
     end
  end

  def eventos
    @eventos = Evento.includes(:local).estado(params[:estado]).esporte(params[:esporte]).paginate(:page => params[:page]).order(:created_at)
    puts @eventos
    @filter = params[:filter] || nil
    @title = "Veja o que esta acontecendo e participe!"
    
    respond_to do |format|
       format.html { @eventos}
       format.js { @eventos }
       format.json { render :json => @eventos.to_json(:include => :local) }
     end
  end
  
  def pistas
    @pistas = Pista.includes(:local).estado(params[:estado]).include().esporte(params[:esporte]).paginate(:page => params[:page]).order(:created_at)
    @filter = params[:filter] || nil
    @title = "Um bom lugar para sua atividade!"
   
    respond_to do |format|
       format.html { @pistas}
       format.js { @pistas }
       format.json { render :json => @pistas.to_json(:include => :local) }
     end
  end

  def blog
  end

  def index
     @title = "Melhores atividades fisicas, lugares e eventos"
  end
  
  def cadastro
    @title = " Cadastre sua loja e seu evento aqui!"
    unless usuario_signed_in?
       render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

end

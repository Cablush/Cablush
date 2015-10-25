class HomeController < ApplicationController
 
  def lojas
    @locais = Local.lojas.paginate(:page => params[:page], :per_page => 9)
    @locais = @locais.lojas_by_estado(params[:estado]) if params[:estado].present?
    @locais = @locais.lojas_by_esporte(params[:esporte]) if params[:esporte].present?
    
    @filter = params[:filter] || nil
    @title = "Em qualquer estado sempre com as lojas proximo de você!"
    
    respond_to do |format|
      format.html {@locais}
      format.js {@locais}
      format.json {render :json => @locais.to_json}
    end
  end

  def eventos
    @locais = Local.eventos.paginate(:page => params[:page], :per_page => 9)
    @locais = @locais.eventos_by_estado(params[:estado]) if params[:estado].present?
    @locais = @locais.eventos_by_esporte(params[:esporte]) if params[:esporte].present?
    
    @filter = params[:filter] || nil
    @title = "Veja o que esta acontecendo e participe!"
    
    respond_to do |format|
      format.html { @locais}
      format.js { @locais }
      format.json { render :json => @locais.to_json }
    end
  end
  
  def pistas
    @locais = Local.pistas.paginate(:page => params[:page], :per_page => 9)
    @locais = @locais.pistas_by_estado(params[:estado]) if params[:estado].present?
    @locais = @locais.pistas_by_esporte(params[:esporte]) if params[:esporte].present?
    
    @filter = params[:filter] || nil
    @title = "Um bom lugar para sua atividade!"
   
    respond_to do |format|
      format.html { @locais}
      format.js { @locais }
      format.json { render :json => @locais.to_json }
    end
  end
  
  def blog
  end

  def index
    @title = "Melhores atividades fisicas, lugares e eventos"
  end
  
  def cadastros
    unless usuario_signed_in?
      render unauthorized
    else
      if current_usuario.admin?
        @title = "Olá Administrador! \"Com grandes poderes vêm grandes responsabilidades\" by Stan Lee!"
      elsif current_usuario.lojista?
        @title = "Olá Lojista! Cadastre sua loja, pista e eventos aqui, e ajude a divulgar o esporte em sua região!"
      else 
        @title = "Olá " + current_usuario.first_name + "! Ajude seu esporte, divulgando as lojas, pistas e eventos de sua região!"
      end
    end
  end

end

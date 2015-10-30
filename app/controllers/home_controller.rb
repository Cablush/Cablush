class HomeController < ApplicationController
 
  def lojas
    @locais = Local.lojas.paginate(:page => params[:page], :per_page => 9)
    @locais = @locais.lojas_by_estado(params[:estado]) if params[:estado].present?
    @locais = @locais.lojas_by_esporte(params[:esporte]) if params[:esporte].present?
    
    @filter = params[:filter] || nil
    @title = "Encontre a loja mais próxima de você!"
    
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
    @title = "Veja o que está acontecendo e participe!"
    
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
    @title = "Onde praticar"
   
    respond_to do |format|
      format.html { @locais}
      format.js { @locais }
      format.json { render :json => @locais.to_json }
    end
  end
  
  def blog
  end

  def index
    @title = "Esportes, lugares e eventos"
  end
  
  def cadastros
    unless usuario_signed_in?
      render unauthorized
    else
      if current_usuario.admin?
        @title = "Olá Administrador!<br> \"Com grandes poderes vêm grandes responsabilidades\" by Stan Lee!".html_safe
      elsif current_usuario.lojista?
        @title = "Olá Lojista!<br> Cadastre sua loja, pista e eventos aqui, e ajude a divulgar o esporte em sua região!".html_safe
      else 
        @title = ("Olá " + current_usuario.first_name + "!<br> Ajude seu esporte, divulgando as lojas, pistas e eventos de sua região!").html_safe
      end
    end
  end

end

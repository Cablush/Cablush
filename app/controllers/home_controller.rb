class HomeController < ApplicationController
 
  def index
    @title = "Esportes, lugares e eventos."
    
    @locais = Local.localizaveis_active
      
    if @locais.empty?
      flash.now[:alert] = 'Nenhuma local encontrado! Cadastre-se no Cablush e divulge as lojas, pistas e eventos da sua região!'
    end
    
    respond_to do |format|
      format.html { @locais }
      format.js { @locais }
      format.json { render json: @locais.to_json }
    end
  end
  
  def about
    @title = "Sobre o Cablush"
  end

  def blog
    @title = "Blog do Cablush"
  end
  
  def cadastros
    unless usuario_signed_in?
      render unauthorized
    else
      if current_usuario.admin?
        @title = "Olá Administrador!<br\> \"Com grandes poderes vêm grandes responsabilidades\" by Stan Lee!".html_safe
      elsif current_usuario.lojista?
        @title = "Olá Lojista!<br\> Cadastre sua loja, pista e eventos aqui, e ajude a divulgar o esporte em sua região!".html_safe
        if current_usuario.lojas.blank?
          flash.now[:alert] = 'Olá Lojista, você ainda não cadastrou sua loja, <a href="cadastros/lojas/new">clique aqui</a> para cadastrar, e começar a divulgar a sua marca!'.html_safe
        end
      else 
        @title = ("Olá " + current_usuario.first_name + "!<br\> Ajude seu esporte, divulgando as lojas, pistas e eventos de sua região!").html_safe
      end
    end
  end

end

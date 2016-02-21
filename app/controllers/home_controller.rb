class HomeController < ApplicationController
 
  def index
    @title = "Esportes, lugares e eventos."
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
        @title = "Olá Administrador!<br> \"Com grandes poderes vêm grandes responsabilidades\" by Stan Lee!".html_safe
      elsif current_usuario.lojista?
        @title = "Olá Lojista!<br> Cadastre sua loja, pista e eventos aqui, e ajude a divulgar o esporte em sua região!".html_safe
      else 
        @title = ("Olá " + current_usuario.first_name + "!<br> Ajude seu esporte, divulgando as lojas, pistas e eventos de sua região!").html_safe
      end
    end
  end

end

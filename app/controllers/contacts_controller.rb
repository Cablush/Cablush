class ContactsController < ApplicationController

  def index
    @title = "Dúvidas, sugestões ou parcerias. Entre em contato conosco!" 
    @contact = Contact.new
  end

  def create
    @title = "Dúvidas, sugestões ou parcerias. Entre em contato conosco!" 
    @contact = Contact.new(params[:contact])

    if @contact.valid?
      ContactMailer.contact_message(params[:contact]).deliver_later
      flash.now[:notice] = 'Mensagem enviada com sucesso'
      redirect_to contact_path
      return  
    end

    render 'index'
  end
  
end

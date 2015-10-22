class ContactsController < ApplicationController
  
  def new
    @title = "Dúvidas, sugestões ou parcerias. Entre em contato conosco!" 
    @contact = Contact.new
  end

  def create
    @title = "Dúvidas, sugestões ou parcerias. Entre em contato conosco!" 
    @contact = Contact.new(params[:contact])

    if @contact.valid?
      ContactMailer.contact_message(params[:contact]).deliver_later
      flash[:notice] = 'Mensagem enviado com sucesso'
      redirect_to :action => 'new'
      return  
    end

    render :action => 'new'
  end
  
end

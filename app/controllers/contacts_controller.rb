class ContactsController < ApplicationController
  def new
    @title = "Entre em contato conosco!" 
    @contact = Contact.new
  end

  def create
    @title = "Entre em contato conosco!" 
     @contact = Contact.new(params[:contact])

    if @contact.valid?
      ContactMailer.contact_message(params[:contact]).deliver
      flash[:notice] = 'Mensagem enviado com sucesso'
      redirect_to :action => 'new'
      return  
    end

    render :action => 'new'
  end
end

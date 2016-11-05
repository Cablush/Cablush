class ContactsController < ApplicationController
  def index
    @title = I18n.t('views.contact.title').html_safe
    @contact = Contact.new
  end

  def create
    @title = I18n.t('views.contact.title').html_safe
    @contact = Contact.new(params[:contact])

    if @contact.valid?
      ContactMailer.contact_message(params[:contact]).deliver_later
      flash.now[:notice] = I18n.t('views.contact.message_sent')
      redirect_to contact_path
      return
    end

    render 'index'
  end
end

class LojaController < ApplicationController
  def new
    if usuario_signed_in? && current_usuario.logista
      @title = 'Cadastre sua loja e fortaleça sua marca!'
      @loja = Loja.new
       respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @loja }
      end
    else
       render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def create
    @loja = Loja.new(params[:rota])

    respond_to do |format|
      if @loja.save
        format.html { redirect_to @loja, notice: 'Loja was successfully created.' }
        format.json { render json: @loja, status: :created, location: @loja }
      else
        format.html { render action: "new" }
        format.json { render json: @loja.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rotas/1
  # DELETE /rotas/1.json
  def destroy
    @loja = Loja.find(params[:id])
    @loja.destroy

    respond_to do |format|
      format.html { redirect_to rotas_url }
      format.json { head :no_content }
    end
  end

  def update
     @loja = Loja.find(params[:id])

    respond_to do |format|
      if @loja.update_attributes(params[:loja])
        format.html { redirect_to @loja, notice: 'Loja was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @loja.errors, status: :unprocessable_entity }
      end
    end
  end
  
  protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to login_path, :notice => 'if you want to add a notice'
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end
  
end

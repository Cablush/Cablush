class PistaController < ApplicationController
  def new
    if usuario_signed_in? && current_user.logista
      @title = 'Os mano pira nas novas pistas!!'
      @pista = Pista.new
       respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @pista }
      end
    else
       render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def create
    @pista = Pista.new(params[:rota])

    respond_to do |format|
      if @pista.save
        format.html { redirect_to @pista, notice: 'Pista was successfully created.' }
        format.json { render json: @pista, status: :created, location: @pista }
      else
        format.html { render action: "new" }
        format.json { render json: @pista.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rotas/1
  # DELETE /rotas/1.json
  def destroy
    @pista = Pista.find(params[:id])
    @pista.destroy

    respond_to do |format|
      format.html { redirect_to rotas_url }
      format.json { head :no_content }
    end
  end

  def update
     @pista = Pista.find(params[:id])

    respond_to do |format|
      if @pista.update_attributes(params[:pista])
        format.html { redirect_to @pista, notice: 'Pista was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pista.errors, status: :unprocessable_entity }
      end
    end
  end
end

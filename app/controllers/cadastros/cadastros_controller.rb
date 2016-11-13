class Cadastros::CadastrosController < ApplicationController
  before_action :authenticate_usuario!

  def find_campeonato_by_uuid(uuid)
    if current_usuario.admin?
      Campeonato.find_by_uuid!(uuid)
    else
      current_usuario.campeonatos.find_by_uuid!(uuid)
    end
  end
end

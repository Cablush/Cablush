class AddUsuarioIdToLoja < ActiveRecord::Migration
  def change
    add_reference :lojas, :usuario, index: true
  end
end

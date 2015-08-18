class AddUsuarioIdToEvento < ActiveRecord::Migration
  def change
  	    add_reference :eventos, :usuario, index: true
  end
end

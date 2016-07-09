class AddCampeonatoRefToEvento < ActiveRecord::Migration
  def change
    add_reference :eventos, :campeonato
  end
end

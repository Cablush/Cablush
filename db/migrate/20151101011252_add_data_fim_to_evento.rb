class AddDataFimToEvento < ActiveRecord::Migration
  def change
    add_column :eventos, :data_fim, :date
    
    Evento.all.each do |evento|
      evento.data_fim = evento.data
      evento.save!
    end
  end
end

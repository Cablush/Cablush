class Esporte < ActiveRecord::Base
  
  enum categoria: {skate: "skate", bike: "bike", patins: "patins"}
  
  def full_name
    categoria.humanize + ' - ' + nome
  end
  
end

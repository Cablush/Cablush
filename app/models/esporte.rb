class Esporte < ActiveRecord::Base
  
  enum categoria: {Skate: 'Skate', Bike: 'Bike', Patins: 'Patins'}
  
  def full_name
    categoria + ' - ' + nome
  end
  
end

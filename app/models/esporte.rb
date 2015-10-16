class Esporte < ActiveRecord::Base

  def full_name
    categoria + ' - ' + nome
  end
  
end

class Horario < ActiveRecord::Base
  
  enum dias: {dia_util: 0, final_de_semana: 1}
  enum periodo: {cheio: 0, meio: 1}
  
  belongs_to :funcionamento, polymorphic: true
  
end

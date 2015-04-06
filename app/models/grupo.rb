class Grupo < ActiveRecord::Base
  has_many :eventos
  has_many :atletas :class_name =>'Usuario'
end

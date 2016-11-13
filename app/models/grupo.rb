class Grupo < ActiveRecord::Base
  belongs_to :responsavel, class_name: "Usuario"

  has_and_belongs_to_many :esportes
  has_and_belongs_to_many :usuarios
  has_and_belongs_to_many :eventos
end

class Estado < ActiveRecord::Base
  has_many :cidade
  has_many :lojas
  has_many :eventos
  has_many :pistas
end

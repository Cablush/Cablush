class Cidade < ActiveRecord::Base
  belongs_to :estado
  has_many :lojas
  has_many :eventos
  has_many :pistas
end

class Categoria < ActiveRecord::Base
  belongs_to :campeonato
  has_many :participantes
end

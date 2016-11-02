class Campeonato::Etapa < ActiveRecord::Base
  belongs_to :campeonato
  has_many :provas
  belongs_to :categoria
end

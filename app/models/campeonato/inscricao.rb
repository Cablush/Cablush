class Campeonato::Inscricao < ActiveRecord::Base
  belongs_to :campeonato
  has_one :categoria
end

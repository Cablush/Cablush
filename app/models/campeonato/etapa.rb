class Campeonato::Etapa < ActiveRecord::Base
  belongs_to :campeonato
  belongs_to :categoria

  has_many :provas
end

class Etapa < ActiveRecord::Base
  belongs_to :campeonato
  has_many :provas
end

class ProvasEtapa < ActiveRecord::Base
	has_one: etapa
	has_one: prova
end

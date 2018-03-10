class Horario < ApplicationRecord
  belongs_to :funcionamento, polymorphic: true
end

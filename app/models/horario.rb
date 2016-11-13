class Horario < ActiveRecord::Base
  belongs_to :funcionamento, polymorphic: true
end

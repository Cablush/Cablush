class Amizade < ApplicationRecord
  belongs_to :usuario, class_name: 'Usuario'
  belongs_to :amigo, class_name: 'Usuario'
end

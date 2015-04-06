class Estado < ActiveRecord::Base
  has_many :cidade
  has_many :local
end

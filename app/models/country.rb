class Country < ActiveRecord::Base
  has_many :estado
  #has_many :cidade
end

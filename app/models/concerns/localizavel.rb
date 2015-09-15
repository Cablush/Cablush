module Localizavel 
  extend ActiveSupport::Concern
  
  included do   
    belongs_to :estado
    belongs_to :cidade
    belongs_to :esporte
    
    per_page = 9
  end
  
  module ClassMethods     
    def estado(search)
      if !search.nil? and search.length > 0
        where(estado_id: search)
      else
        all
      end
    end
    
    def esporte(search)
      if !search.nil? and search.length > 0
        where(esporte_id: search)
      else
        all
      end
    end
  end
  
end

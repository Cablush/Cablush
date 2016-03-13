class Estado < ActiveRecord::Base
  
  belongs_to :country
  has_many :cidade
  
  scope :from_country, ->(country) { 
    joins(:country).where('countries.iso = ?', "#{country}") if country.present? 
  }
  
  def self.save?(rg_estado, nome_estado, pais_estado) 
    if Estado.from_country(pais_estado).find_by_rg(rg_estado).blank?
      country = Country.find_by_iso(pais_estado)
      if country.present?
        Estado.create(rg: rg_estado, nome: nome_estado, country: country)
      end
    end
  end
  
end

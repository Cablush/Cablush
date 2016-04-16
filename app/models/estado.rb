class Estado < ActiveRecord::Base
  
  belongs_to :country, :class_name => 'Country'
  has_many :cidade
  
  scope :from_country, ->(country) { 
    joins(:country).where('countries.iso = ?', "#{country}") if country.present? 
  }
  
  def self.save?(rg_estado, nome_estado, iso_pais) 
    if Estado.from_country(iso_pais).find_by_rg(rg_estado).blank?
      country = Country.find_by_iso(iso_pais)
      if country.present?
        Estado.create(rg: rg_estado, nome: nome_estado, country: country)
      end
    end
  end
  
end

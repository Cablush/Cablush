class Pista < ActiveRecord::Base
  
  belongs_to :responsavel, class_name: "Usuario"
  
  has_one :local, as: :localizavel, dependent: :destroy
  accepts_nested_attributes_for :local, 
                                reject_if: proc { |attributes| attributes['logradouro'].blank? },
                                allow_destroy: true
  
  has_many :horarios, as: :funcionamento, dependent: :destroy
  accepts_nested_attributes_for :horarios, 
                                reject_if: proc { |attributes| attributes['dias'].blank? },
                                allow_destroy: true
  
  has_and_belongs_to_many :esportes
  
  has_attached_file :foto, 
                    :styles => { 
                      :small => "340x200>",
                      :original => "1024x768>"
                    },
                    :path => "/pistas/:id/:basename_:style.:extension"

  validates_attachment :foto, 
    :size => { :in => 0..5.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png)$/ }
    
end

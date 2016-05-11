class Campeonato < ActiveRecord::Base
  
  belongs_to :participantes, class_name: "Usuario"
  belongs_to :responsavel, class_name: "Usuario"
  
  
  has_many :etapas, dependent: :destroy
  accepts_nested_attributes_for :etapas, allow_destroy: true
  
  has_one :horario, as: :funcionamento, dependent: :destroy
  accepts_nested_attributes_for :horario, allow_destroy: true
  
  has_and_belongs_to_many :esportes
  has_and_belongs_to_many :eventos
  
  is_impressionable
  
 
  
  def to_param
    uuid
  end
  
  validates :nome, presence: true, length: { maximum: 50 }
  validates :descricao, presence: true, length: { maximum: 500 }
  validates :data_inicio, presence: true
  validates :hora, presence: true
  validates :data_fim, presence: true

     
  scope :find_like_name, ->(nome) {
    where('campeonato.nome LIKE ?', "#{nome}%") if nome.present?
  }
  
  def responsavel_uuid
    responsavel.uuid
  end
  
  def as_json(options={})
    super(:only => [:nome, :descricao, :uuid],
          :methods => [ :responsavel_uuid]
    )
  end
  
  def share_message
    return 'O Campeonato ' + nome + ' esta no Cablush! Se inscreva'
  end
end

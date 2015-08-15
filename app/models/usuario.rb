class Usuario < ActiveRecord::Base
  enum role: {admin: 0, lojista: 1, esportista: 2}
  
  has_many :amigos, :class_name =>'Amizade'
  has_many :lojas
  has_many :eventos
  has_many :pistas
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 
#  attr_accessible :email, :password, :password_confirmation

  # lojista: utilizado no cadastro para identificar um lojista
  attr_accessor :lojista

  after_initialize :set_default_role, :if => :new_record?
  
  private
  
  def set_default_role
    self.role ||= :esportista
  end
  
end

class Usuario < ActiveRecord::Base
  has_many :amigos, :class_name =>'Amizade'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 
#attr_accessible :email, :password, :password_confirmation
end

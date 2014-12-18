class User < ActiveRecord::Base
  acts_as_voter
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :explanations
  has_many :solutions
  
  #has_many :comments
  #attributes: name, background [string. for now]
end

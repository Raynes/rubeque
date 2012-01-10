class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  field :username
  field :email

  validates_uniqueness_of :email, :username

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
end

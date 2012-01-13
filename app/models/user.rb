class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  field :username
  field :email
  field :solution_count, type: Integer
  field :admin, type: Boolean

  references_many :solutions

  validates_uniqueness_of :email, :username

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :admin
end

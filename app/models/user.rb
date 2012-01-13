class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  field :username
  field :email
  field :score, type: Integer
  field :solution_count, type: Integer
  field :admin, type: Boolean

  references_many :solutions
  references_many :votes
  references_many :problems, inverse_of: :creator

  validates_uniqueness_of :email, :username

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :admin
  
  after_create :initialize_score

  def to_s
    username
  end
  
  protected
  
    def initialize_score
      self.score = 0
      self.save
    end
end

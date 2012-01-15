class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  field :username
  field :email
  field :score, type: Integer
  field :solution_count, type: Integer
  field :admin, type: Boolean

  references_many :solutions
  references_many :votes
  references_many :problems, inverse_of: :creator
  references_many :following, inverse_of: :follower

  validates_uniqueness_of :email, :username

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :admin
  attr_accessor :users_followed

  after_create :initialize_score

  def to_s
    username
  end

  def update_score
    upvotes = solutions.map{|s| s.votes.where(:up => true)}.flatten
    downvotes = solutions.map{|s| s.votes.where(:up => false)}.flatten
    update_attribute(:score, upvotes.count - downvotes.count)
  end

  def users_followed
    @user_followed ||= following.map(&:user)
  end

  def following?(user)
    users_followed.include?(user)
  end

  protected

    def initialize_score
      self.score = 0
      self.save
    end
end

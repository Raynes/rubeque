class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, :omniauthable,
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
  references_many :user_tokens, autosave: true, dependent: :destroy

  index :score, :solution_count

  validates_uniqueness_of :username
  validates_presence_of :username
  validates :email,
            presence: true,
            uniqueness: true,
            format: { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i },
            allow_nil: -> user { user.user_tokens.empty? }

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :admin
  attr_accessor :users_followed
  #attr_protected :provider, :uid, :name, :email

  after_create :initialize_score

  def to_s
    username
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session[:omniauth]
        user.user_tokens.build(:provider => data['provider'], :uid => data['uid'])
      end
    end
  end

  def apply_omniauth(omniauth)
    self.username = (omniauth['info']['nickname'] rescue nil) if username.blank?
    user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (user_tokens.empty? || !password.blank?) && super
  end

  def email_required?
    user_tokens.length == 0
  end

  def self.find_for_open_id(access_token, signed_in_resource=nil)
    data = access_token.info
    if user = User.where(:email => data["email"]).first
      user
    else
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20])
    end
  end

  def update_score
    upvotes = solutions.map{|s| s.votes.where(:up => true)}.flatten
    downvotes = solutions.map{|s| s.votes.where(:up => false)}.flatten
    update_attribute(:score, upvotes.count - downvotes.count)
  end

  def users_followed
    @user_followed ||= following.sort_by{|f| f.user.username.downcase}.map(&:user)
  end

  def following?(user)
    users_followed.include?(user)
  end

  def update_solution_count
    update_attribute(:solution_count, solutions.count)
  end

  protected

    def initialize_score
      self.score = 0
      self.save
    end
end

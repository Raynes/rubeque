class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::History::Trackable

  devise :database_authenticatable, :registerable, :lockable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  field :username
  field :email
  field :score, type: Integer, :default => 0
  field :solution_count, type: Integer
  field :rank, type: Integer
  field :admin, type: Boolean

  ## Devise fields
  ## Database authenticatable
  field :email,              :type => String, :null => false
  field :encrypted_password, :type => String, :null => false

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Encryptable
  field :password_salt, :type => String

  ## Lockable
  field :failed_attempts, :type => Integer # Only if lock strategy is :failed_attempts
  field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  field :locked_at,       :type => Time

  references_many :solutions
  references_many :votes
  references_many :problems, inverse_of: :creator
  references_many :following, inverse_of: :follower
  references_many :user_tokens, autosave: true, dependent: :destroy

  index :score, :solution_count

  validates_uniqueness_of :username
  validates_presence_of :username

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  attr_accessor :users_followed
  #attr_protected :provider, :uid, :name, :email

  before_create :initialize_rank

  track_history :on => [:username, :email, :admin],
                :track_create   => true,
                :track_destroy  => true

  def solved_problems
    @solved_problems ||= Hash[solutions.map{|solution| [solution.problem_id,solution.score]}]
  end
  
  def solved_problem_scores
    solved_problems
  end
  
  def scores_page
    (rank.to_i / User.default_per_page.to_f).ceil
  end
  
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
    difficulty_points = solutions.map{|s| s.problem.difficulty}.sum
    update_attribute(:score, upvotes.count - downvotes.count + difficulty_points)
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
  def initialize_rank
    self.rank = User.count + 1
  end
end

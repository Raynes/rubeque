class Solution
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::History::Trackable
  field :code
  field :score, type: Integer
  field :time, type: Float
  field :cheating, type: Boolean

  referenced_in :problem
  referenced_in :user
  references_many :votes, dependent: :destroy

  index [:problem_id, :user_id]

  scope :cheating, where(cheating: true)
  scope :not_cheating, any_in(cheating: [nil, false])

  validate :run_problem
  after_create :update_user_solution_count, :create_upvote_for_solution
  validates_uniqueness_of :problem_id, scope: :user_id,
    message: "solution error. Please do not use the back button in your browser before submitting a solution."
  after_destroy :update_user_solution_count
  validates_presence_of :problem_id

  paginates_per 5

  track_history :track_create   => true,
                :track_destroy  => true

  attr_accessible :code
  attr_accessible :code, :cheating, :user_id, :problem_id, as: :admin

  def update_score
    update_attribute(:score, calculated_score)
  end

  def calculated_score
    votes.upvote.count - votes.downvote.count + (problem.try(:value) || 0)
  end

  def run_problem
    executor = CodeExecutor.new(combined_code, excluded_methods: problem.excluded_methods)
    result = executor.execute
    executor.errors.each {|e| errors.add(:base, e)}
    self.time = executor.time
    return result
  end

  def self.duplicates(callback = nil, sort = :asc)
    duplicates = []
    Solution.all(sort: [[:updated_at, sort]]).each do |solution|
      conditions = { problem_id: solution.problem.id,
                     user_id: solution.user_id,
                     id: { "$nin" => [solution.id] }
                   }
      if (dupes = Solution.all(conditions: conditions)).any?
        solution.send(callback) if callback
        duplicates << solution
      end
    end

    duplicates
  end

  def combined_code
    full_code = problem.code.clone
    full_code += ("\n" + problem.hidden_code) if problem.hidden_code
    full_code.gsub("__"){self.code}
  end

  def share_code
    # don't add in hidden_code because we don't want it showing up on twitter
    share_code = problem.code.clone
    share_code.gsub("__"){self.code}
  end

  def character_count
    self.code.gsub(/\s/, "").length
  end

  protected

    def create_upvote_for_solution
      self.votes.create(:user => user, :up => true) if user
    end

    def update_user_solution_count
      self.user.update_solution_count
    end
    
end

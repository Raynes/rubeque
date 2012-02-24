class Solution
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::History::Trackable
  field :code
  field :score, type: Integer
  field :time, type: Float

  referenced_in :problem
  referenced_in :user
  references_many :votes, dependent: :destroy

  index [:problem_id, :user_id]

  validate :run_problem
  after_create :update_user_solution_count, :create_upvote_for_solution
  validates_uniqueness_of :problem_id, scope: :user_id,
    message: "solution error. Please do not use the back button in your browser before submitting a solution."
  after_destroy :update_user_solution_count

  track_history :track_create   => true,
                :track_destroy  => true

  def update_score
    update_attribute(:score, votes.upvote.count - votes.downvote.count)
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
    full_code = problem.code
    full_code += ("\n" + problem.hidden_code) if problem.hidden_code

    while(i = full_code.rindex("__"))
      full_code[i..i+1] = self.code
    end

    full_code
  end

  def share_code
    # don't add in hidden_code because we don't want it showing up on twitter
    share_code = problem.code
    while(i = share_code.rindex("__"))
      share_code[i..i+1] = self.code
    end

    share_code
  end

  protected

    def create_upvote_for_solution
      self.votes.create(:user => user, :up => true) if user
    end

    def update_user_solution_count
      # TODO: find all the solutions and update the user's solution count?
      if user_id && (updating_user = User.find(self.user_id))
        updating_user.solution_count = updating_user.solutions.count
        updating_user.save
      end
    end
    
end

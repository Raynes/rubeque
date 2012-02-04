class Solution
  include Mongoid::Document
  include Mongoid::Timestamps
  field :code
  field :score, type: Integer

  referenced_in :problem
  referenced_in :user
  references_many :votes, dependent: :destroy

  index [:problem_id, :user_id]

  validate :run_problem
  after_create :update_user_solution_count, :create_upvote_for_solution

  def update_score
    update_attribute(:score, votes.upvote.count - votes.downvote.count)
  end

  def run_problem
    load "#{Rails.root}/app/classes/code_executor.rb"
    executor = CodeExecutor.new(problem.code.gsub("__", self.code), excluded_methods: problem.excluded_methods)
    result = executor.execute
    executor.errors.each {|e| errors.add(:base, e)}
    return result
  end

  protected

    def create_upvote_for_solution
      self.votes.create(:user => user, :up => true) if user
    end

    def update_user_solution_count
      # TODO: find all the solutions and update the user's solution count?
      if user_id && (updating_user = User.find(self.user_id))
        updating_user.solution_count = user.solution_count ? user.solution_count + 1 : 1
        updating_user.save
      end
    end
    
end

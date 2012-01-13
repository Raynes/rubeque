class Solution
  include Mongoid::Document
  include Mongoid::Timestamps
  field :code

  referenced_in :problem
  referenced_in :user
  references_many :votes

  validate :run_problem
  after_create :update_user_solution_count, :create_upvote_for_solution

  def score
    votes.upvote.count - votes.downvote.count
  end

  protected

    def run_problem
      # initialize test unit
      require 'test/unit'
      extend Test::Unit::Assertions

      # get our code
      problem_code = problem.code.gsub("__", self.code)

      # run it
      begin
        FakeFS.activate!
        evaluator = Proc.new do
          $SAFE = 3
          eval(problem_code)
        end
        success = evaluator.call
        errors.add(:base, "Your solution failed.") unless success
      rescue Exception => e
        errors.add(:base, "Your solution failed: #{e.message}")
      ensure
        FakeFS.deactivate!
      end
    end
    
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

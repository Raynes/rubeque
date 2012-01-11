class Solution
  include Mongoid::Document
  field :code

  embedded_in :problem, :inverse_of => :solutions
  referenced_in :user, :inverse_of => :solutions

  validate :run_problem

  protected

    def run_problem
      # initialize test unit
      require 'test/unit'
      extend Test::Unit::Assertions

      # get our code
      problem_code = problem.code.gsub("__", self.code)

      # run it
      begin
        eval(problem_code)
      rescue Exception => e
        errors.add(:base, "Your solution failed: #{e.message}")
      end
    end
end

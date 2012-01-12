module UsersHelper

  def user_solution_count(user)
    Problem.all.inject(0) { |result, problem| result += (problem.solutions.detect {|s| s.user == user}.nil? ? 0 : 1) }
  end
end

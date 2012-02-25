class ProblemMailer < ActionMailer::Base
  default from: "support@rubeque.com"

  def new_problem_email(problem)
    @problem = problem
    mail(:to => ENV['notification_email'], :subject => "New problem submitted on Rubeque.com")
  end
end

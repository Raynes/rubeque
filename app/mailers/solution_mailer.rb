class SolutionMailer < ActionMailer::Base
  default from: "support@rubeque.com"

  def cheating_notification(solution, user)
    @solution = solution
    @user = user

    mail :to => ENV['notification_email'],
      subject: "A new problem has been marked for cheating on Rubeque.com"
  end
end

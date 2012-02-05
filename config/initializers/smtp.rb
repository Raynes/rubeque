ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "rubeque.com",
  :user_name            => ENV['smtp_username'],
  :password             => ENV['smtp_password'],
  :authentication       => "plain",
  :enable_starttls_auto => true
}

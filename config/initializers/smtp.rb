ActionMailer::Base.smtp_settings = {
  :address              => "email-smtp.us-east-1.amazonaws.com",
  :port                 => 465,
  :domain               => "rubeque.com",
  :user_name            => ENV['smtp_username'],
  :password             => ENV['smtp_password'],
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
  :access_key_id     => ENV['smtp_username'],
  :secret_access_key => ENV['smtp_password']

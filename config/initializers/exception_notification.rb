Rubeque::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[Rubeque Exception] ",
  :sender_address => %{"Exception Notifier" <support@rubeque.com>},
  :exception_recipients => ENV['exception_recipients']

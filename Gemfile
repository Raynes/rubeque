source 'http://rubygems.org'

gem "rails", "~> 3.2.2"
gem "mongoid", "~> 2.4"
gem "bson_ext", "~> 1.5"
gem "coderay", "~> 1.0.5"
gem 'fakefs', :require => "fakefs/safe"
gem 'jquery-rails'
gem 'devise', '~> 2.0.4'
gem "rinku"
gem 'exception_notification', :require => 'exception_notifier'
gem 'sicuro'
gem 'mongoid-history'
gem 'kaminari'
gem 'chosen-rails'
gem "uuid", "~> 2.3.5"
gem "rack-timeout"
gem "aws-ses", "~> 0.4.4", :require => 'aws/ses'
gem "rubyheap", "~> 0.1.1"

# omniauth gems
gem 'omniauth', '~> 1.0.1'
gem "omniauth-twitter"
gem "omniauth-github"
gem "omniauth-openid"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem "newrelic_rpm"
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test, :development do
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'rspec-rails', "~> 2.8"
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'awesome_print'
  gem 'interactive_editor'
end

group :development do
  # bash < <(curl -L https://raw.github.com/gist/1333785)
  rvm_path = ENV['rvm_path']
  gem 'linecache19','0.5.13'
  gem 'ruby-debug-base19', '0.11.26'
  gem 'ruby-debug19', '0.11.6',:require => 'ruby-debug'
  gem 'heroku'
end

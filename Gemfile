source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem "mongoid", "~> 2.4"
gem "bson_ext", "~> 1.5"
gem "coderay", "~> 1.0.5"
gem 'fakefs', :require => "fakefs/safe"
gem 'jquery-rails'
gem 'devise', '~> 1.5.3'
gem "rinku"
gem 'rubycop'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'rspec-rails', "~> 2.8"
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end

group :development do
  # bash < <(curl -L https://raw.github.com/gist/1333785)
  rvm_path = ENV['rvm_path']
  gem 'linecache19','0.5.13'
  gem 'ruby-debug-base19', '0.11.26'
  gem 'ruby-debug19', '0.11.6',:require => 'ruby-debug'
end

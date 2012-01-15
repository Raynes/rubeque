source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem "mongoid", "~> 2.4"
gem "bson_ext", "~> 1.5"
gem "coderay", "~> 1.0.5"
gem 'fakefs', :require => "fakefs/safe"
gem 'jquery-rails'
gem 'devise', '~> 1.5.3'
gem 'omniauth', '~> 1.0.1'
gem "omniauth-twitter"
gem "omniauth-github"

group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test do
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

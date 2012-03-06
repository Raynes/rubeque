# This file is used by Rack-based servers to start the application.
require 'newrelic_rpm'
require ::File.expand_path('../config/environment',  __FILE__)
run Rubeque::Application

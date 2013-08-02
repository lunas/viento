source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'pg'
gem 'mysql2'

gem 'simple_form'
gem 'haml'
gem 'cancan'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'devise'
gem 'will_paginate'
gem 'factory_girl_rails'
gem 'ffaker'
gem 'coffee-rails', '~> 3.2.1'
gem 'client_side_validations'
 # gem 'client_side_validations-simple_form'
gem 'goldmine',  :git => 'https://github.com/lunas/goldmine.git'
gem 'decent_exposure'
gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'

gem 'rails-settings'

gem 'whenever', :require => false

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'haml-rails'
  gem 'sass-rails',   '~> 3.2.3'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem 'compass_twitter_bootstrap'
  gem 'compass-rails'

end

group :test, :development do
  gem 'awesome_print'
end

group :test do
  gem 'spork'
#  gem 'capybara-webkit', :git => 'https://github.com/thoughtbot/capybara-webkit.git'
  gem 'database_cleaner'
  gem 'timecop'
  gem 'shoulda-matchers'
  gem 'launchy'
  gem 'email_spec'
  gem 'mocha'
  gem 'rspec-expectations'
  gem 'rspec-rails'
end

#https://github.com/bkeepers/dotenv
#Reads environment variables from a .env file in the project root (.gitignored so secret variables aren't in github)
gem 'dotenv', :groups => [:development, :test]


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'debugger'

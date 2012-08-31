source 'https://rubygems.org'

gem 'rails', '3.2.6'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'haml'
gem 'cancan'
gem 'jquery-rails'
gem 'devise'
gem 'omniauth-twitter'
gem 'will_paginate'
gem 'factory_girl_rails'
gem 'ffaker'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'haml-rails'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem 'compass_twitter_bootstrap'
  gem 'compass-rails'

end

group :test, :development do
  gem 'rspec-rails'
  gem 'ruby-debug19'
  gem 'rspec-expectations'
  gem 'spork', '~> 0.9.0.rc'
  gem 'awesome_print'
end

group :test do
  gem 'cucumber-rails'
#  gem 'capybara-webkit', :git => 'https://github.com/thoughtbot/capybara-webkit.git'
  gem 'database_cleaner'
  gem 'timecop'
  gem 'shoulda-matchers'
  gem 'launchy'
  gem 'email_spec'
  gem 'viewcumber'
  gem 'mocha'
end

#https://github.com/bkeepers/dotenv
#Reads environment variables from a .env file in the project root (.gitignored so secret variables aren't in github)
gem 'dotenv', :groups => [:development, :test]


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

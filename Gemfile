source 'https://rubygems.org'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use sqlite3 as the database for Active Record
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'bootstrap-sass', '3.2.0.1'
gem "bower-rails", "~> 0.10.0"
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem "mini_magick"
#gem 'will_paginate'
gem 'kaminari'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
gem "font-awesome-rails"
gem 'devise'
gem 'sendgrid'
gem 'ransack'
gem 'acts_as_votable', '~> 0.10.0'
gem 'shareable'
gem "figaro"
gem 'rails-html-sanitizer','~> 1.0.3'
gem "launchy"
gem 'annotate'
gem 'acts-as-taggable-on', '~> 3.4'
gem 'jquery-ui-rails'
gem 'rails3-jquery-autocomplete'
gem "jquery-fileupload-rails"
gem 'simplecov', :require => false, :group => :test
gem 'fog'
gem 'bootsy'
gem 'file_validators'
gem 'delayed_job_active_record'


# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'rspec-rails', '~> 3.0'
  gem 'sqlite3'
  gem 'capybara'
  #gem 'capybara-email'
  gem "factory_girl_rails", "~> 4.0"
  gem "faker"
  gem "capybara-webkit"
  gem "mailcatcher"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'brakeman', :require => false

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
  gem 'puma',           '3.1.0'
end

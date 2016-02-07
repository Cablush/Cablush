source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'

gem 'rails-i18n'

# Sidekiq allows you to move jobs into the background for asynchronous processing.
gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
#gem 'jquery-ui-themes'
gem 'rails-jquery-autocomplete'

#gem 'jquery-turbolinks'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

gem 'lightbox2-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development
gem 'mina'

gem 'will_paginate','~> 3.0.6'
gem 'has_scope'

gem 'mail_form'
gem 'simple_form'

gem 'devise', '~> 3.5.6'
gem 'devise_token_auth', '~> 0.1.37'
gem 'omniauth'
#gem 'omniauth-facebook'
#gem 'omniauth-google-oauth2'

gem 'activerecord-session_store'

#a pedido do openshift
#gem 'turbo-sprockets-rails3'

gem "paperclip"
gem "aws-sdk", "~> 1.6"

gem "font-awesome-rails"

group :production do
  gem 'mysql2', '~> 0.3.18'
  gem 'passenger'
end

group :development do
  gem 'sqlite3'
  gem 'byebug'
  gem 'rails-erd'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'quiet_assets'
  gem "fakes3"
end

source 'https://rubygems.org'

# Ruby on Rails is a full-stack web framework
gem 'rails', '5.0.6'
# A set of common locale data and translations to internationalize and/or localize your Rails applications.
gem 'rails-i18n'
# Find out which locale the user preferes by reading the languages they specified in their browser
gem 'http_accept_language'

# A Ruby/Rack web server built for concurrency
gem 'puma'
# Simple, efficient background processing for Ruby.
gem 'sidekiq'
# Clean ruby syntax for writing and deploying cron jobs.
gem 'whenever'

# Log impressions from controller actions or from a model
gem 'impressionist'
# An Action Dispatch session store backed by an Active Record class.
gem 'activerecord-session_store'
# Makes http fun! Also, makes consuming restful web services dead easy.
gem 'httparty'

# # Sass adapter for the Rails asset pipeline.
gem 'sass-rails'
# Uglifier minifies JavaScript files by wrapping UglifyJS to be accessible in Ruby
gem 'uglifier'

# Forms made easy!
gem 'simple_form'
# Send e-mail straight from forms in Rails with I18n, validations, attachments and request information.
gem 'mail_form'
# Easy upload management for ActiveRecord
gem 'paperclip'

# Flexible authentication solution for Rails with Warden
gem 'devise'
# Facebook OAuth2 Strategy for OmniAuth
gem 'omniauth-facebook'
# A Google OAuth2 strategy for OmniAuth 1.x
gem 'omniauth-google-oauth2'
# Simple (but safe) token authentication for Rails apps or API with Devise.
gem 'simple_token_authentication'
# Koala is a lightweight, flexible Ruby SDK for Facebook.
gem 'koala', '~> 2.2'

# Provides jQuery and the jQuery-ujs driver for your Rails 4+ application.
gem 'jquery-rails'
# jQuery UI's JavaScript, CSS, and image files packaged for the Rails 3.1+ asset pipeline
gem 'jquery-ui-rails'
# Use jQuery's autocomplete plugin with Rails 4+.
gem 'rails-jquery-autocomplete'
# Provides jQuery FancyBox 2 for your Rails 3.1/4.0 application. This gem is based on the gem for Fancybox 1.x by Chris Mytton
gem 'fancybox2-rails'
# Provides a simple API for performing paginated queries with Active Record
gem 'will_paginate','~> 3.0.6'
# I like font-awesome. I like the asset pipeline.
gem 'font-awesome-rails'
# jquery datatables for rails
gem 'jquery-datatables-rails'

# Makes following links in your web application faster (use with Rails Asset Pipeline)
gem 'turbolinks'
# jQuery plugin for drop-in fix binded events problem caused by Turbolinks
gem 'jquery-turbolinks'

group :production do
  # A simple, fast Mysql library for Ruby, binding to libmysql
  gem 'mysql2'
  # SitemapGenerator is a framework-agnostic XML Sitemap generator written in Ruby with automatic Rails integration.
  gem 'sitemap_generator'
end

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Spring speeds up development by keeping your application running in the background.
  gem 'spring'
  # pretty print Ruby objects to visualize their structure.
  gem 'awesome_print', require: 'ap'
  # Provides a better error page for Rails and other Rack apps
  gem 'better_errors'
  # help to kill N+1 queries and unused eager loading.
  gem 'bullet'
  # Automatically generate an entity-relationship diagram (ERD) for your Rails models.
  gem 'rails-erd'
  # Use FakeS3 to test basic S3 functionality without actually connecting to S3
  gem 'fakes3'
end

group :test do
  gem 'capybara'
  gem 'faker'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'rails-controller-testing'
  gem 'launchy'
  gem 'factory_girl'
  gem 'factory_girl_rails'
end

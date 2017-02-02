source 'https://rubygems.org'

# Ruby on Rails is a full-stack web framework
gem 'rails', '4.2.6'
# A set of common locale data and translations to internationalize and/or
# localize your Rails applications.
gem 'rails-i18n'
# Find out which locale the user preferes by reading the languages they
# specified in their browser
gem 'http_accept_language'

# Simple, efficient background processing for Ruby.
gem 'sidekiq'
# Clean ruby syntax for writing and deploying cron jobs.
gem 'whenever'

# DSL for quickly creating web applications in Ruby with minimal effort.
gem 'sinatra', require: false
# Template language whose goal is reduce the syntax to the essential parts
# without becoming cryptic.
gem 'slim'
# Log impressions from controller actions or from a model
gem 'impressionist'
# Create JSON structures via a Builder-style DSL
gem 'jbuilder', '~> 1.2'
# Maps controller filters to your resource scopes
gem 'has_scope'
# An Action Dispatch session store backed by an Active Record class.
gem 'activerecord-session_store'
# Makes http fun! Also, makes consuming restful web services dead easy.
gem 'httparty'

# Sass adapter for the Rails asset pipeline.
gem 'sass-rails', '~> 4.0.0'
# Uglifier minifies JavaScript files by wrapping UglifyJS to be accessible
# in Ruby
gem 'uglifier', '>= 1.3.0'
# CoffeeScript adapter for the Rails asset pipeline.
gem 'coffee-rails', '~> 4.0.0'

# Forms made easy!
gem 'simple_form'
# Send e-mail straight from forms in Rails with I18n, validations, attachments
# and request information.
gem 'mail_form'
# Easy upload management for ActiveRecord
gem 'paperclip', '~> 4.3.6'

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
# The official AWS SDK for Ruby.
gem 'aws-sdk', '~> 1.6'

# Provides jQuery and the jQuery-ujs driver for your Rails 4+ application.
gem 'jquery-rails'
# jQuery UI's JavaScript, CSS, and image files packaged for the Rails 3.1+
# asset pipeline
gem 'jquery-ui-rails'
# Use jQuery's autocomplete plugin with Rails 4+.
gem 'rails-jquery-autocomplete'
# Provides jQuery FancyBox 2 for your Rails 3.1/4.0 application. This gem is
# based on the gem for Fancybox 1.x by Chris Mytton
gem 'fancybox2-rails'
# Provides a simple API for performing paginated queries with Active Record
gem 'will_paginate','~> 3.0.6'
# I like font-awesome. I like the asset pipeline.
gem 'font-awesome-rails'
# jquery datatables for rails
gem 'jquery-datatables-rails'

# Makes following links in your web application faster (use with Rails Asset
# Pipeline)
#gem 'turbolinks'
# jQuery plugin for drop-in fix binded events problem caused by Turbolinks
#gem 'jquery-turbolinks'

group :doc do
  # rdoc generator html with javascript search index.
  gem 'sdoc', require: false
end

group :production do
  # A simple, fast Mysql library for Ruby, binding to libmysql
  #gem 'mysql2', '~> 0.3.18'
  # A modern web server and application server for Ruby, Python and Node.js
  gem 'passenger'
  # Really fast deployer and server automation tool.
  gem 'mina'
  # SitemapGenerator is a framework-agnostic XML Sitemap generator written in
  # Ruby with automatic Rails integration.
  gem 'sitemap_generator'
end

group :development, :test do
  # Allows Ruby programs to interface with the SQLite3 database engine
  gem 'sqlite3'
  # Provides a better error page for Rails and other Rack apps.
  gem 'better_errors'
  # Retrieve the binding of a method's caller. Can also retrieve bindings even
  # further up the stack.
  gem 'binding_of_caller'
  # Quiet Assets turns off Rails asset pipeline log.
  gem 'quiet_assets'
  # Use FakeS3 to test basic S3 functionality without actually connecting to S3
  gem 'fakes3'
  # rspec-rails is a testing framework for Rails 3.x and 4.x.
  gem 'rspec-rails'
  # factory_girl_rails provides integration between factory_girl and rails 3
  gem 'factory_girl_rails'
end

group :development do
  # Byebug is a Ruby 2 debugger.
  gem 'byebug'
  # Automatically generate an entity-relationship diagram (ERD) for your Rails
  # models.
  gem 'rails-erd'
end

group :test do
  # Faker, a port of Data::Faker from Perl, is used to easily generate fake
  # data: names, addresses, phone numbers, etc.
  gem 'faker'
  # Capybara is an integration testing tool for rack based web applications.
  # It simulates how a user would interact with a website
  gem 'capybara'
  # Guard::RSpec automatically run your specs (much like autotest).
  gem 'guard-rspec'
  # Launchy is helper class for launching cross-platform applications in a fire
  # and forget manner.
  gem 'launchy'
  # Strategies for cleaning databases. Can be used to ensure a clean state for
  # testing.
  gem 'database_cleaner'
end

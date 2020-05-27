# frozen_string_literal: true

ruby File.read('.ruby-version').strip
source 'https://rubygems.org'

gem ...

# bundle --without development --without test
%i[development test].tap do |groups|
  gem 'pry', group: groups, require: true
  gem 'pry-byebug', group: groups, require: false
  gem 'pry-rails', group: groups, require: true
end

# bundle --without development
group :development do
  gem 'guard', require: false               # Run commands on file change
  gem 'guard-bundler', require: false       # Re-run `bundle install`
  gem 'guard-process', require: false       # Re-start a process on file change
  gem 'guard-rspec', require: false         # Run rspec when test are modified
  gem 'guard-rubocop', require: false       # Check code style with RuboCop
  gem 'guard-shell', require: false         # Run shell commands on file change
end

# bundle --without test
group :test do
  gem 'cucumber', require: false            # Behaviour driven development
  gem 'page-object', require: false         # Webpage interaction via Watir
  gem 'rack-test', require: false           # Test module for Rack applications
  gem 'rspec', require: false               # Test driven development
  gem 'rubocop', require: false             # Static code analyser
  gem 'rubocop-performance', require: false # Performance optimization analysis
  gem 'rubocop-rails', require: false       # Rubocop checker for Rails
  gem 'rubocop-rspec', require: false       # Rubocop checker for Rspec
  gem 'rubocop-sequel', require: false      # Rubocop checker for Sequel
  gem 'simplecov', require: false           # Code coverage report generator
end

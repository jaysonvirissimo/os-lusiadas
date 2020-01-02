# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.6.5'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'actionview'
gem 'active_recall', '~> 1.0'
gem 'authem'
gem 'bootsnap'
gem 'bulma-rails'
gem 'coffee-rails'
gem 'easy_translate'
gem 'jbuilder'
gem 'nokogiri'
gem 'pg'
gem 'puma'
gem 'rack'
gem 'rails', '6.0.0'
gem 'railties'
gem 'sass-rails'
gem 'skylight'
gem 'turbolinks'
gem 'uglifier'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

group :development, :test do
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'fabrication'
  gem 'rspec-rails', '4.0.0.beta3'
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

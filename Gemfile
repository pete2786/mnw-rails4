source 'https://rubygems.org'

gem 'rails', '4.2.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'draper'

gem 'rabl'
gem 'oj'
gem 'responders'

#looks
gem 'bootstrap-sass', '~> 3.3.4'
gem 'simple_form'
gem 'image-picker-rails'

# authorization/authentication
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'rolify'
gem 'cancancan', '~> 1.10'

# Phrase and weather management
gem 'open-weather'
gem "mini_magick"
gem 'carrierwave'
gem 'carrierwave-aws'

# Merit
gem 'merit'

#deploy
gem 'capistrano', '2.15.5'
gem 'rvm-capistrano', '1.2.7', require: false

group :production do
  gem 'mysql2'
end

group :development do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'pry-rails'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end


group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end


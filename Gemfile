source 'https://rubygems.org'

gem 'rails', '6.0.2'
gem 'sass-rails', '~> 5.0'
gem 'uglifier'
gem 'coffee-rails'
gem 'actionpack'
gem 'activemodel'
gem 'activesupport'
gem 'railties'

gem 'jquery-rails'
gem 'jbuilder'
gem 'sdoc', group: :doc
gem 'mini_racer', platforms: :ruby
gem 'pg'
gem 'paperclip'
gem 'bcrypt'
gem 'sorcery'
gem 'filesize'
gem 'videojs_rails'

group :production do
  gem 'unicorn'
end

group :development, :test do
  gem 'byebug'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_bot_rails'

  gem 'rubocop', require: false

  gem 'rspec_junit_formatter'

  # capybara
  gem 'capybara'
  gem 'poltergeist'
  gem 'turnip'

  # deploy
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano3-unicorn'
end

group :development do
  gem 'web-console'
  gem 'rails-erd'
  gem 'spring'
end

group :test do
  gem 'shoulda-matchers'
end

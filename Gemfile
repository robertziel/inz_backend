source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(File.expand_path('.ruby-version', __dir__)).chomp

# CORE

gem 'rails', '~> 6.0.2.2'
gem 'pg', '>= 0.18', '< 2.0'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'puma', '~> 4.3.3'

# API

gem 'grape'
gem 'grape-kaminari', github: 'robertziel/grape-kaminari'
gem 'grape-swagger'
gem 'grape-swagger-rails'
gem 'kaminari'
gem 'rack-cors'

# Frontend

gem 'haml'

# Security

gem 'bcrypt', '~> 3.1.12'
gem 'dotenv-rails'
gem 'devise'

# Other

gem 'browser'
gem 'draper'
gem 'gravatar_image_tag'
gem 'mini_magick'
gem 'active_model_serializers'
gem 'activeadmin'
gem 'active_admin-state_machine'
gem 'state_machine'

group :development do
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  gem 'rails-erd'
  gem 'capistrano'
  gem 'capistrano-passenger'
  gem 'capistrano-rvm' # rvm support
  gem 'capistrano-bundler' # bundle command
  gem 'capistrano-rails' # assets and migrations
  gem 'capistrano-faster-assets' # skips assets precompilation if not needed
  gem 'capistrano3-git-push'
  gem 'capistrano-git-copy', require: false
end

group :development, :test do
  gem 'pry'
end

group :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.8'
  gem 'shoulda'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

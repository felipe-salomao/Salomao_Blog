source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.7'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use Puma as the app server
gem 'puma', '~> 5.0'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

# Render image on ActionText
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "simple_form", "~> 5.3"

gem "kaminari", "~> 1.2"

gem "devise", "~> 4.9"

gem "pundit", "~> 2.3"

gem 'rolify', '~> 6.0'

gem "groupdate", "~> 5.2"

gem 'devise-i18n', "~> 1.10.1"

gem 'dotenv-rails'

gem 'sidekiq', '~> 6.4'

group :development, :rspec, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'rspec-rails', '~> 6.0'

  gem 'factory_bot_rails', '~> 6.2'

  gem 'faker', '~> 3.3', '>= 3.3.1'

  gem 'shoulda-matchers', '~> 4.5', '>= 4.5.1'

  gem 'rails-controller-testing'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'

  gem 'rack-mini-profiler', '~> 2.0'

  gem "letter_opener", "~> 1.10"

  gem "bullet"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'

  gem 'selenium-webdriver', '>= 4.0.0.rc1'

  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

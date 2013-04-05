source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'mysql2'
# to use a worker to get states periodicly
gem 'clockwork',  "~> 0.5.0"
gem 'tzinfo',     "~> 0.3.35"
# to run the worker like a daemon
gem 'daemons'
gem 'i2c',        "~> 0.2.0"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem "twitter-bootstrap-rails"
  # to precompile assets faster
  gem 'turbo-sprockets-rails3'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Deploy with Capistrano
group :development, :test do
  gem 'capistrano'
  gem 'capistrano_colors'
  gem 'better_errors'
end


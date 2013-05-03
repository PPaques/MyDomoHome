source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'mysql2'
# to use a worker to get states periodicly
gem 'clockwork',  '~> 0.5.0'
gem 'tzinfo',     '~> 0.3.35'
# to run the worker like a daemon
gem 'daemons'
gem 'i2c', '~> 0.2.22'
gem 'nested_form'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'twitter-bootstrap-rails'
  # to precompile assets faster
  gem 'turbo-sprockets-rails3'
  gem 'haml'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'flot-rails'
gem 'font-awesome-rails'

# Deploy with Capistrano
group :development, :test do
  gem 'capistrano'
  gem 'capistrano_colors'
  gem 'capistrano-unicorn', :require => false
  gem 'better_errors'
end


gem 'unicorn' unless RUBY_PLATFORM == 'i386-mingw32'

# group :production do
#   gem 'unicorn', :require => false
# end

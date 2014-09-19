source 'https://rubygems.org'

gem 'rails', '4.1.1'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'sqlite3'
  gem 'byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'mocha', :require => false
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

gem 'yourub', :git => 'git://github.com/edap/yourub.git', ref: 'ba8435e33457a6c2d861dae8144e215df0579fd7'

gem 'faye-websocket'
gem 'redis'
gem 'puma'

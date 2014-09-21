source 'https://rubygems.org'

ruby '2.1.1'

gem 'rails', '4.1.1'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'sqlite3'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
end

group :test do
  gem 'mocha', :require => false
end

group :development, :test do
  gem 'byebug'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'yourub', :git => 'git://github.com/edap/yourub.git', ref: 'ba8435e33457a6c2d861dae8144e215df0579fd7'
gem 'eshq'
gem 'newrelic_rpm'

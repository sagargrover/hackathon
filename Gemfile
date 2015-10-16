source 'https://7jz8eUPLXyB3hSa6vaRT@repo.fury.io/loconsolutions/'
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.9'
gem 'acl_service', '0.0.7'
gem 'httparty'
gem 'rack-ssl-enforcer'
gem 'housing_dply', '0.1.13'
gem 'uglifier', '2.6.1'

gem 'rack-cors', :require => 'rack/cors'

#My custom gems. 
gem 'pg'
gem 'activerecord-postgis-adapter'
gem 'rgeo-geojson'
gem "redis"
gem "activerecord-import", '>=0.4.0'
gem "elasticsearch"
gem "resque", "~> 1.25.1", :require=>"resque/server"
gem 'resque-loner'
gem 'resque-scheduler', '2.5.5'
gem 'resque-queue-priority', '~> 0.6.2'
gem 'figaro', '0.7.0'
gem "bunny"
gem "sneakers"
gem 'will_paginate'

gem "bootstrap-timepicker-rails", "~> 0.1.3"
gem "bootstrap-datepicker-rails", "1.4.0"
gem 'jquery-rails', '3.1.3' 
gem 'jquery-tokeninput-rails'
gem 'turbolinks'
gem 'simple_form', '3.1.0'
gem 'ckeditor'

#New
gem "oj", "~> 2.0.14"
gem "newrelic_rpm"
gem 'lograge-with-time', '~> 0.4.0', require: 'lograge'
gem 'dalli'

gem 'jquery-ui-rails', '5.0.3'
gem 'bootstrap-wysiwyg-rails'

# 'bundle exec rake rdoc' generates the API under doc/api.
gem 'sdoc', '~>0.4.1'

# for implemeting sweepers
gem 'rails-observers'

group :development do
  gem "rails-erd"
  gem 'ruby-prof'
  gem 'thin'
  gem "better_errors"
  gem 'hirb'
  gem 'awesome_print'#, :require => 'ap'
  gem 'brakeman'
end

group :development, :test do 
  gem 'pry', '~> 0.9.12.6'
  gem 'pry-rails'
  gem 'pry-byebug'
end

group :test do
  # To send the test coverage report to code climate
  gem 'minitest'
  gem 'mocha'
  gem "codeclimate-test-reporter", require: nil
end

group :assets do
  gem 'sprockets', '2.11.0'
end

# source 'https://rubygems.org'
source 'http://gems.ruby-china.org'

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# 用户管理
gem 'cancancan'
gem 'devise'
gem 'rolify'

# YAML 配置信息
gem 'settingslogic'

# 表单
gem 'simple_form'

gem 'http_accept_language'

# Markdown格式文本处理
gem 'coderay'
gem 'redcarpet'

# 上传图片
gem 'carrierwave'
gem 'mini_magick'

# 分页
gem 'will_paginate'

# Redis 命名空间
gem 'redis-namespace'

# Redis 保存阅读量
gem 'redis-objects'

# friendly id
gem 'friendly_id', '~> 5.1.0'

# migration注释
gem 'migration_comments'

# Sidekiq 队列
gem 'sidekiq'
# Sidekiq Web
gem 'sinatra', require: nil

# OAuth 2.0
gem 'doorkeeper'
gem 'doorkeeper-i18n'

# API
gem 'active_model_serializers', '~> 0.10.0'
gem 'grape'
gem 'grape-active_model_serializers'

# API 文档
gem 'grape-swagger'
gem 'grape-swagger-rails'

# for API 跨域
gem 'rack-cors', require: 'rack/cors'
gem 'rack-utf8_sanitizer'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  gem 'rspec-rails', '~> 3.5.2'

  gem 'pry'
  gem 'pry-nav'
  gem 'rubocop', '~> 0.57.2', require: false
end

group :test do
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'faker'
  gem 'launchy'
  gem 'selenium-webdriver'

  gem 'database_cleaner'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # monitor 监控
  gem 'rack-mini-profiler', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

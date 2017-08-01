# source 'https://rubygems.org'
source 'https://ruby.taobao.org/'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
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

# 用户管理
gem 'devise'
gem 'rolify'
gem 'cancancan'

# YAML 配置信息
gem 'settingslogic'

# 表单
gem 'simple_form'

gem 'http_accept_language'

# Markdown格式文本处理
gem 'redcarpet'
gem 'coderay'

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

# Sidekiq 队列
gem 'mina-sidekiq', :require => false
gem 'sidekiq'
# Sidekiq Web
gem 'sinatra', require: nil

# Use Unicorn as the app server
gem 'mina-unicorn', :require => false
gem 'unicorn'

# OAuth 2.0
gem 'doorkeeper', github: 'doorkeeper-gem/doorkeeper'
gem 'doorkeeper-i18n'

# API
gem 'grape'
gem 'active_model_serializers', '~> 0.10.0'
gem 'grape-active_model_serializers'

# API 文档
gem 'grape-swagger'
gem 'grape-swagger-rails'

# for API 跨域
gem 'rack-cors', require: 'rack/cors'
gem 'rack-utf8_sanitizer'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'rspec-rails', '~> 3.5.2'
  gem 'rspec-collection_matchers'
  gem 'rails-controller-testing'
  gem 'factory_girl_rails'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'launchy'
  gem 'selenium-webdriver'

  gem 'database_cleaner'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # monitor 监控
  gem 'rack-mini-profiler', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

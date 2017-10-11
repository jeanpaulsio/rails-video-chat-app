source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# rails
gem 'rails',        '~> 5.1.4'

gem 'bcrypt',       '~> 3.1', '>= 3.1.11'
gem 'bootstrap',    '~> 4.0.0.beta'
gem 'coffee-rails', '~> 4.2'
gem 'figaro',       '~> 1.1', '>= 1.1.1'
gem 'friendly_id',  '~> 5.2', '>= 5.2.3'
gem 'jbuilder',     '~> 2.5'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'json',         '~> 2.1'
gem 'pg',           '~> 0.18'
gem 'puma',         '~> 3.7'
gem 'redis',        '~> 3.0'
gem 'rest-client',  '~> 2.0', '>= 2.0.2'
gem 'sass-rails',   '~> 5.0'
gem 'turbolinks',   '~> 5'
gem 'uglifier',     '>= 1.3.0'

# react on rails
gem 'react_on_rails', '9.0.0'
gem 'webpacker',      '~> 3.0'

# favicon
group :development do
  gem 'rails_real_favicon'
end

# authentication
gem 'devise',            '~> 4.3'
gem 'devise_token_auth', '~> 0.1.42'
gem 'omniauth',          '~> 1.7'

# api
gem 'rack-cors', '~> 0.4.1'

group :test do
  gem 'guard',                    '~> 2.14', '>= 2.14.1'
  gem 'guard-minitest',           '~> 2.4', '>= 2.4.6'
  gem 'minitest-reporters',       '~> 1.1', '>= 1.1.18'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.2'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console',           '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'mini_racer', platforms: :ruby
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder',     '~> 2.5'
gem 'pg',           '~> 0.18'
gem 'puma',         '~> 3.7'
gem 'rails',        '~> 5.1.4'
gem 'sass-rails',   '~> 5.0'
gem 'turbolinks',   '~> 5'
gem 'uglifier',     '>= 1.3.0'

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

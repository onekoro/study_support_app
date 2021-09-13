
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 6.1.3.1'
gem 'bcrypt',         '3.1.13'
gem 'puma',       '4.3.6'
gem 'sass-rails', '5.1.0'
gem 'webpacker',  '4.0.7'
gem 'turbolinks', '5.2.0'
gem 'jbuilder',   '2.9.1'
gem 'bootsnap',   '1.4.5', require: false
gem 'font-awesome-sass'
gem 'slim-rails'
gem 'html2slim'
gem 'rails-i18n'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog-aws'
gem 'faker',                   '2.1.2'
gem 'gimei'
gem 'kaminari'
gem 'ransack'
gem "geocoder"
gem "chartkick"
gem 'pg', '1.1.4'

group :development, :test do
  gem 'rspec-rails', '~> 4.0.0'
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'byebug',  '11.0.1', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console',           '4.0.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'spring-commands-rspec'
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-rails", "~> 1.6", require: false
  gem 'capistrano-rbenv', '~> 2.2'
  gem 'capistrano-rbenv-vars', '~> 0.1'
  gem 'capistrano3-puma'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'
end

group :test do
  gem 'capybara',                 '3.28.0'
  gem 'launchy', '~> 2.4.3'
  gem 'selenium-webdriver',       '3.142.4'
  gem 'webdrivers',               '4.1.2'
  gem 'rails-controller-testing', '1.0.4'
  gem 'shoulda-matchers'
  gem 'guard',                    '2.16.2'
  gem 'rspec_junit_formatter'
end

group :production do
  # gem 'pg', '1.1.4'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

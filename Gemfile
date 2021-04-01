
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails',      '6.0.3'
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
gem 'kaminari'
gem 'ransack'
gem "geocoder"
gem "dotenv-rails"

group :development, :test do
  gem 'rspec-rails', '~> 4.0.0'
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'sqlite3', '1.4.1'
  gem 'byebug',  '11.0.1', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console',           '4.0.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara',                 '3.28.0'
  gem 'launchy', '~> 2.4.3'
  gem 'selenium-webdriver',       '3.142.4'
  gem 'webdrivers',               '4.1.2'
  gem 'rails-controller-testing', '1.0.4'
  gem 'shoulda-matchers'
  gem 'guard',                    '2.16.2'
  # gem 'guard-minitest',           '2.4.6'
end

group :production do
  gem 'pg', '1.1.4'
end

# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
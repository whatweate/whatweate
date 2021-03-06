source "https://rubygems.org"

gem "rails", "4.2.2"
gem "pg"
gem "puma"
gem "uglifier"
gem "sass-rails"
gem "jquery-rails"
gem "turbolinks"
gem "rails_config"
gem "devise"
gem "gravatar_image_tag"
gem "simple_form"
gem "omniauth"
gem "omniauth-twitter"
gem "omniauth-facebook"
gem "draper"
gem "rollbar"
gem "money-rails"
gem "redcarpet"
gem "aasm"
gem "wisper"
gem "validate_url"
gem "slack-notifier"
gem "wisper-activerecord"
gem "friendly_id"
gem "stripe"
gem "date_time_attribute"
gem "carrierwave", github: "carrierwaveuploader/carrierwave", ref: "c60ee75291de332fa341308d837f4cb0c15d44ca"
gem "mini_magick"
gem "jquery-turbolinks"
gem "newrelic_rpm"
gem "sidekiq"
gem "autoprefixer-rails"
gem "carrierwave-aws"

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem "rspec-rails", "~> 3.0"
  gem "pry"
  gem "factory_girl_rails"
  gem "faker"
  gem "letter_opener"
  gem "dotenv-rails"
end

group :development do
  gem "spring"
  gem "rubocop", require: false
  gem "guard-livereload", require: false
  gem "scss_lint", require: false
end

group :test do
  gem "capybara"
  gem "poltergeist"
  gem "shoulda-matchers"
  gem "codeclimate-test-reporter", require: nil
  gem "wisper-rspec", require: false
  gem "webmock"
  gem "vcr"
  gem "test_after_commit"
  gem "database_cleaner"
end

ruby "2.2.2"

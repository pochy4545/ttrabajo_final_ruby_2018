source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'
#para json serializer
gem 'jbuilder', '~> 2.5'
gem 'active_model_serializers', '~> 0.10.0'
#para verificacion de creacion 
gem 'faraday'
gem 'oj'
#para test 
gem 'test_helper'
gem 'json'
gem 'database_cleaner'
group :development, :test do
  gem 'factory_bot_rails'
end
group :development, :test do
  gem 'rspec-rails', '~> 3.6'
end
gem 'pry-byebug'
gem 'faker'

group :test do
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'rails-controller-testing' # If you are using Rails 5.x
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1', '>= 5.2.1.1'
# Use mysql as the database for Active Record
group :development, :test do
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
end
group :production do 
  gem 'pg'
  gem 'rails_12factor', '0.0.2'

end
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

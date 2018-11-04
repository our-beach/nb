source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'ffi', '>= 1.9.24'
gem 'loofah', '>= 2.2.3'
gem 'sprockets', '>= 3.7.2'
gem 'rails-html-sanitizer', '>= 1.0.4'

gem 'attr_encrypted', '~> 3.0.0'
gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'bcrypt', '~> 3.1.7'
gem 'figaro', '~> 1.0'
gem 'phony'
gem 'redis'
gem 'jsonapi-rb'
gem 'jsonapi-rails'
gem 'jwt'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry', '~> 0.11.3'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-doc'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard'
  gem 'guard-rails'
  gem 'guard-rspec'
end

group :test do
  gem 'rspec-rails', '~>3.7'
  gem 'shoulda-matchers', '~>3.1.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

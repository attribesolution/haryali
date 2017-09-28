source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby '2.4.1'
gem 'rails', '~> 5.1.1'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem "font-awesome-rails"
gem 'simple_form'
gem 'jquery-ui-rails'
gem 'jquery-validation-rails'
group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end
group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'bootstrap-tooltip-rails'
gem 'devise'
gem 'devise-i18n'
gem 'devise_invitable'
gem 'carrierwave', '~> 0.10.0'
gem 'mini_magick', '~> 4.3'
gem 'fog'
gem 'jquery-rails'
gem 'pg'
gem 'slim-rails'
gem 'therubyracer', :platform=>:ruby
gem 'rails_script', '~> 2.0'
gem 'cocoon'
gem "figaro"
gem 'gmaps4rails'
gem 'greensock-rails', '~> 1.19'
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end
group :development do
  # gem 'better_errors'
  gem 'foreman'
  gem 'rails_layout'
  gem 'spring-commands-rspec'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
  gem 'rubocop'
end
group :test do
  gem 'database_cleaner'
  gem 'launchy'
end

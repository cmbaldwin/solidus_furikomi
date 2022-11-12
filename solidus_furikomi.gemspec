# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'solidus_furikomi/version'

Gem::Specification.new do |s|
  s.name        = 'solidus_furikomi'
  s.version     = SolidusFurikomi::VERSION
  s.summary     = 'Solidus Furikomi (Japanese Bank Transfer)'
  s.description = 'Solidus Furikomi (Japanese Bank Transfer)'
  s.license     = 'BSD-3-Clause'

  s.authors    = ['Fabrizio Monti', 'Cody Baldwin']
  s.email     = 'codybaldwin@gmail.com'
  s.homepage  = 'https://cozyorb.com'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'solidus_core'

  s.add_development_dependency 'capybara', '~> 3.28'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner', '~> 1.7'
  s.add_development_dependency 'ffaker', '~> 2.11'
  s.add_development_dependency 'gem-release'
  s.add_development_dependency 'pry-byebug', '~> 3.7'
  s.add_development_dependency 'rspec-rails', '~> 3.8'
  s.add_development_dependency 'rubocop', '~> 0.74.0'
  s.add_development_dependency 'rubocop-performance', '~> 1.4'
  s.add_development_dependency 'rubocop-rails', '~> 2.3'
  s.add_development_dependency 'rubocop-rspec', '~> 1.35'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver', '~> 3.142'
  s.add_development_dependency 'shoulda-matchers', '~> 4.1'
  s.add_development_dependency 'simplecov', '~> 0.17.0'
  s.add_development_dependency 'webdrivers', '~> 4.1'
end

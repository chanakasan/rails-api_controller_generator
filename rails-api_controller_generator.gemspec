Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.3'
  s.name        = 'rails-api_controller_generator'
  s.version     = '0.7.0'
  s.summary     = 'Generates API controllers with endpoints for basic crud operations.'
  s.description = 'Generates API controllers with endpoints for basic crud operations for a model.'
  s.author      = 'Chanaka Sandaruwan'
  s.email       = 'chanakasan@gmail.com'
  s.files       = Dir['lib/**/*.rb']
  s.require_paths = ['lib']
  s.homepage    = 'https://github.com/chanakasan/rails-api_controller_generator'
  s.license     = 'Apache License, Version 2.0'
end

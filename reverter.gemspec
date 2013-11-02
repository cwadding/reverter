$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "reverter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "reverter"
  s.version     = Reverter::VERSION
  s.authors     = ["Chris Waddington"]
  s.email       = ["cwadding@gmail.com"]
  s.homepage    = "https://github.com/cwadding/reverter"
  s.summary     = "Easily add undo and redo logic to your rails application."
  s.description = "A rails engine to add undo and redo buttons to your flash messages."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.1"
  s.add_dependency "paper_trail", "~> 3.0.0.rc1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rake"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'#, '~> 2.10.0'
end

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_cas_server/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_cas_server"
  s.version     = RailsCasServer::VERSION
  s.authors     = ["Greg Molnar"]
  s.email       = ["greg@molnar.io"]
  s.homepage    = "https://github.com/gregmolnar/rails_cas_server"
  s.summary     = "Summary of RailsCasServer."
  s.description = "Description of RailsCasServer."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 5.2.0"
  s.add_dependency "activerecord-session_store"
  s.add_dependency "secure_headers", '~> 2.0.0'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
  s.add_development_dependency "capybara"
  s.add_development_dependency "pry-byebug"
end

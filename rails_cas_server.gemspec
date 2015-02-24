$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_cas_server/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_cas_server"
  s.version     = RailsCasServer::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RailsCasServer."
  s.description = "TODO: Description of RailsCasServer."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.4"
  s.add_dependency "activerecord-session_store"
  s.add_dependency "secure_headers"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
  s.add_development_dependency "capybara"
  s.add_development_dependency "pry-byebug"
end

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bootstrap_form_builder/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bootstrap_form_builder"
  s.version     = BootstrapFormBuilder::VERSION
  s.authors     = ["John Parker"]
  s.email       = ["jparker@urgetopunt.com"]
  s.homepage    = "http://github.com/jparker/bootstrap_form_builder"
  s.summary     = "Twitter Bootstrap-friendly form builder"
  s.description = "Rails form builder for use with Twitter's Bootstrap library, with labels and inline errors."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0.rc1"

  s.add_development_dependency 'mocha'
  s.add_development_dependency "sqlite3"
end

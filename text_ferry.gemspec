# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "text_ferry/version"

Gem::Specification.new do |s|
  s.name        = "text_ferry"
  s.version     = TextFerry::VERSION
  s.authors     = ["Bob Nadler"]
  s.email       = ["bnadlerjr@gmail.com"]
  s.homepage    = "https://github.com/bnadlerjr/text_ferry"
  s.summary     = %q{A DSL for loading CSV text files into a database.}
  s.description = %q{A DSL for loading CSV text files into a database.}

  s.rubyforge_project = "text_ferry"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "contest", "~> 0.1.3"
  s.add_development_dependency "rake", "~> 10.1.1"
  s.add_development_dependency "rdoc", "~> 4.1.1"
  s.add_development_dependency "sqlite3", "~> 1.3.4"

  s.add_runtime_dependency "sequel", "~> 4.8.0"
end

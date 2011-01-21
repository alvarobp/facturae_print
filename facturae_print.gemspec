# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "facturae_print/version"

Gem::Specification.new do |s|
  s.name        = "facturae_print"
  s.version     = FacturaePrint::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alvaro Bautista"]
  s.email       = ["alvarobp@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{facturae_print translates a facturae xml file into an understandable HTML or PDF file}
  s.description = %q{facturae_print translates a facturae xml file into an understandable HTML or PDF file}

  s.rubyforge_project = "facturae_print"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
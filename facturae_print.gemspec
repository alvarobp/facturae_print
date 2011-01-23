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

  s.add_dependency("nokogiri", ">= 1.4.4")
  s.add_dependency("erubis", ">= 2.6.6")
  s.add_dependency("wkhtmltopdf-binary", ">= 0.9.5.1")
  s.add_dependency("pdfkit", ">= 0.5.0")
  
  s.add_development_dependency("rspec", "~> 2.4.0")
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

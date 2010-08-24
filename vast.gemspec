# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "vast"
  s.version     = "1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chris Dinn"]
  s.email       = ["chrisgdinn@gmail.com"]
  s.homepage    = "http://github.com/chrisdinn/vast"
  s.summary     = "A gem for working with VAST 2.0 documents" 
  
  s.files       = Dir['lib/*.rb'] + Dir['lib/*.xsd'] + Dir['lib/vast/*.rb'] + Dir['test/*.rb'] + Dir['test/examples/*.xml'] + %w(LICENSE README.rdoc)
  
  s.add_dependency 'nokogiri', '~> 1.4.3'
  
  s.require_path = 'lib'
end